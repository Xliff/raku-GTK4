use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GTK::Raw::Types:ver<4>;
use GTK::Raw::RecentManager:ver<4>;

use GLib::GList;

use GLib::Roles::Implementor;
use GLib::Roles::Object;
use GIO::Roles::Icon;
use GIO::Roles::AppInfo;

our subset GtkRecentManagerAncestry is export of Mu
  where GtkRecentManager | GObject;

class GTK::RecentManager:ver<4> {
  also does GLib::Roles::Object;

  has GtkRecentManager $!gtk-rm is implementor;

  submethod BUILD ( :$gtk-recent-manager ) {
    self.setGtkRecentManager($gtk-recent-manager)
      if $gtk-recent-manager
  }

  method setGtkRecentManager (GtkRecentManagerAncestry $_) {
    my $to-parent;

    $!gtk-rm = do {
      when GtkRecentManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkRecentManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GTK::Raw::Definitions::GtkRecentManager
   is also<GtkRecentManager>
  { $!gtk-rm }

  multi method new (
     $gtk-recent-manager where * ~~ GtkRecentManagerAncestry,

    :$ref = True
  ) {
    return unless $gtk-recent-manager;

    my $o = self.bless( :$gtk-recent-manager );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $gtk-recent-manager = gtk_recent_manager_new();

    $gtk-recent-manager ?? self.bless( :$gtk-recent-manager ) !! Nil;
  }
  multi method new ( :$default is required ) {
    ::?CLASS.get_default;
  }

  method get_default is also<get-default> {
    my $gtk-recent-manager = gtk_recent_manager_get_default();

    $gtk-recent-manager ?? self.bless( :$gtk-recent-manager ) !! Nil;
  }

  method add_full (
    Str()              $uri,
    GtkRecentData()    $recent_data
  )
    is also<add-full>
  {
    gtk_recent_manager_add_full($!gtk-rm, $uri, $recent_data);
  }

  method add_item (Str() $uri) is also<add-item> {
    gtk_recent_manager_add_item($!gtk-rm, $uri);
  }

  method error_quark is static is also<error-quark> {
    gtk_recent_manager_error_quark();
  }

  method get_items ( :$raw = False, :$glist = False ) is also<get-items> {
    returnGList(
      gtk_recent_manager_get_items($!gtk-rm),
      $raw,
      $glist,
      |GTK::Recent::Info.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_recent_manager_get_type, $n, $t );
  }

  method has_item (Str() $uri) is also<has-item> {
    so gtk_recent_manager_has_item($!gtk-rm, $uri);
  }

  method lookup_item (
    Str()                    $uri,
    CArray[Pointer[GError]]  $error,
                            :$raw    = False
  )
    is also<lookup-item>
  {
    clear_error;
    my $rv = gtk_recent_manager_lookup_item($!gtk-rm, $uri, $error);
    set_error($error);
    propReturnObject($rv, $raw, |GTK::Recent::Info.getTypePair);
  }

  method move_item (
    Str()                    $uri,
    Str()                    $new_uri,
    CArray[Pointer[GError]]  $error    = gerror,
                            :$raw      = False
  )
    is also<move-item>
  {
    clear_error;
    my $rv = gtk_recent_manager_move_item($!gtk-rm, $uri, $new_uri, $error);
    set_error($error);
    propReturnObject($rv, $raw, |GTK::Recent::Info.getTypePair);
  }

  method purge_items (CArray[Pointer[GError]] $error = gerror)
    is also<purge-items>
  {
    clear_error;
    gtk_recent_manager_purge_items($!gtk-rm, $error);
    set_error($error);
  }

  method remove_item (
    Str()                   $uri,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-item>
  {
    gtk_recent_manager_remove_item($!gtk-rm, $uri, $error);
  }

}

class GTK::Recent::Info {
  also does GLib::Roles::Implementor;

  has GtkRecentInfo $!gtk-ri is implementor;

  submethod BUILD ( :gtk-recent-info( :$!gtk-ri ) )
  { }

  method GTK::Raw::Definitions::GtkRecentInfo
    is also<GtkRecentInfo>
  { $!gtk-ri }

  method new (GtkRecentInfo $gtk-recent-info) {
    $gtk-recent-info ?? self.bless( :$gtk-recent-info ) !! Nil
  }

  method create_app_info (
    Str()                    $app_name,
    CArray[Pointer[GError]]  $error     = gerror,
                            :$raw       = False
  )
    is also<create-app-info>
  {
    clear_error($error);
    my $ri = gtk_recent_info_create_app_info($!gtk-ri, $app_name, $error);
    set_error($error);
    propReturnObject($ri, $raw, |GIO::AppInfo.getTypePair);
  }

  method exists {
    so gtk_recent_info_exists($!gtk-ri);
  }

  method get_added is also<get-added> {
    gtk_recent_info_get_added($!gtk-ri);
  }

  method get_age is also<get-age> {
    gtk_recent_info_get_age($!gtk-ri);
  }

  proto method get_application_info (|)
    is also<get-application-info>
  { * }

  multi method get_application_info (Str() $app_name, :$raw = False) {
    samewith(
      $app_name,
      newCArray(Str),
      $,
      newCArray(GDateTime),
      :$raw
    );
  }
  multi method get_application_info (
    Str()                       $app_name,
    CArray[Str]                 $app_exec,
                                $count     is rw,
    CArray[Pointer[GDateTime]]  $stamp,
                               :$raw              = False
  ) {
    my guint $c = 0;

    gtk_recent_info_get_application_info(
      $!gtk-ri,
      $app_name,
      $app_exec,
      $c,
      $stamp
    );

    (
      ppr($app_exec),
      $count,
      propReturnObject( ppr($stamp), $raw, |GLib::DateTime.getTypePair )
    );
  }

  proto method get_applications
    is also<get-applications>
  { * }

  multi method get_applications  {
    samewith($, :all);
  }
  multi method get_applications ($length is rw, :$all = False) {
    my gsize $l = 0;

    my $rl = gtk_recent_info_get_applications($!gtk-ri, $l);
    $length = $l;

    $rl = CArrayToArray($rl);

    $all.not ?? $rl !! ( $rl, $length );
  }

  method get_description is also<get-description> {
    gtk_recent_info_get_description($!gtk-ri);
  }

  method get_display_name is also<get-display-name> {
    gtk_recent_info_get_display_name($!gtk-ri);
  }

  method get_gicon ( :$raw = False ) is also<get-gicon> {
    propReturnObject(
      gtk_recent_info_get_gicon($!gtk-ri),
      $raw,
      |GIO::Icon.getTypePair
    );
  }

  method get_groups (Int() $length) is also<get-groups> {
    my gsize $l  = $length;
    my       $sa = gtk_recent_info_get_groups($!gtk-ri, $l);

    CArrayToArray($sa, :free);
  }

  method get_mime_type is also<get-mime-type> {
    gtk_recent_info_get_mime_type($!gtk-ri);
  }

  method get_modified is also<get-modified> {
    gtk_recent_info_get_modified($!gtk-ri);
  }

  method get_private_hint is also<get-private-hint> {
    gtk_recent_info_get_private_hint($!gtk-ri);
  }

  method get_short_name is also<get-short-name> {
    gtk_recent_info_get_short_name($!gtk-ri);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_recent_info_get_type, $n, $t );
  }

  method get_uri is also<get-uri> {
    gtk_recent_info_get_uri($!gtk-ri);
  }

  method get_uri_display is also<get-uri-display> {
    gtk_recent_info_get_uri_display($!gtk-ri);
  }

  method get_visited is also<get-visited> {
    gtk_recent_info_get_visited($!gtk-ri);
  }

  method has_application (Str() $app_name) is also<has-application> {
    so gtk_recent_info_has_application($!gtk-ri, $app_name);
  }

  method has_group (Str() $group_name) is also<has-group> {
    so gtk_recent_info_has_group($!gtk-ri, $group_name);
  }

  method is_local is also<is-local> {
    so gtk_recent_info_is_local($!gtk-ri);
  }

  method last_application is also<last-application> {
    gtk_recent_info_last_application($!gtk-ri);
  }

  method match (GtkRecentInfo() $info_b) {
    so gtk_recent_info_match($!gtk-ri, $info_b);
  }

  method ref {
    gtk_recent_info_ref($!gtk-ri);
    self;
  }

  method unref {
    gtk_recent_info_unref($!gtk-ri);
  }
}

INIT {
  my \O = GTK::RecentManager;
  %widget-types{O.get_type} = {
    name        => O.^name,
    object      => O,
    pair        => O.getTypePair
  }
}
