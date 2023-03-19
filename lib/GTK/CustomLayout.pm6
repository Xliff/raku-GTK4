use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::LayoutManager:ver<4>;

our subset GtkCustomLayoutAncestry is export of Mu
  where GtkCustomLayout | GtkLayoutManagerAncestry;

class GTK::CustomLayout:ver<4> is GTK::LayoutManager:ver<4> {
  has GtkCustomLayout $!gtk-cl is implementor;

  submethod BUILD ( :$gtk-custom-layout ) {
    self.setGtkCustomLayout($gtk-custom-layout) if $gtk-custom-layout
  }

  method setGtkCustomLayout (GtkCustomLayoutAncestry $_) {
    my $to-parent;

    $!gtk-cl = do {
      when GtkCustomLayout {
        $to-parent = cast(GtkLayoutManager, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkCustomLayout, $_);
      }
    }
    self.setGtkLayoutManager($to-parent);
  }

  method GTK::Raw::Definitions::GtkCustomLayout
    is also<GtkCustomLayout>
  { $!gtk-cl }

  multi method new (
    $gtk-custom-layout where * ~~ GtkCustomLayoutAncestry,

    :$ref = True
  ) {
    return unless $gtk-custom-layout;

    my $o = self.bless( :$gtk-custom-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new (&request-mode, &measure, &allocate) {
    my $gtk-custom-layout = gtk_custom_layout_new(
      &request-mode,
      &measure,
      &allocate
    );

    $gtk-custom-layout ?? self.bless( :$gtk-custom-layout ) !! Nil;
  }
  multi method new (
    :$request  = Callable, 
    :$measure  = Callable,
    :$allocate = Callable
  ) {
    samewith($request, $measure, $allocate);
  }
}

### /usr/src/gtk4/gtk/gtkcustomlayout.h

sub gtk_custom_layout_new (
  &request_mode (GtkWidget --> GtkSizeRequestMode),
  &measure (
    GtkWidget,
    GtkOrientation,
    gint,
    CArray[gint],
    CArray[gint],
    CArray[gint],
    CArray[gint]
  ),
  &allocate (GtkWidget, gint, gint, gint)
)
  returns GtkCustomLayout
  is      native(gtk4)
  is      export
{ * }
