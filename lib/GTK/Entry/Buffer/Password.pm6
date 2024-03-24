use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Types:ver<4>;

use GTK::Entry::Buffer:ver<4>;

use GLib::Roles::Implementor;

our subset GtkPasswordEntryBufferAncestry is export of Mu
  where GtkPasswordEntryBuffer | GtkEntryBufferAncestry;

class GTK::EntryBuffer::Password:ver<4> is GTK::Entry::Buffer:ver<4> {
  has GtkPasswordEntryBuffer $!gtk-peb is implementor;

  submethod BUILD ( :$gtk-pass-entry-buffer ) {
    self.setGtkPasswordEntryBuffer($gtk-pass-entry-buffer)
      if $gtk-pass-entry-buffer
  }

  method setGtkPasswordEntryBuffer (GtkPasswordEntryBufferAncestry $_) {
    my $to-parent;

    $!gtk-peb = do {
      when GtkPasswordEntryBuffer {
        $to-parent = cast(GtkEntryBuffer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkPasswordEntryBuffer, $_);
      }
    }
    self.setGtkEntryBuffer($to-parent);
  }

  method GTK::Raw::Definitions::GtkPasswordEntryBuffer
    is also<GtkPasswordEntryBuffer>
  { $!gtk-peb }

  multi method new (
    $gtk-pass-entry-buffer where * ~~ GtkPasswordEntryBufferAncestry,

    :$ref = True
  ) {
    return unless $gtk-pass-entry-buffer;

    my $o = self.bless( :$gtk-pass-entry-buffer );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gtk-pass-entry-buffer = gtk_password_entry_buffer_new();

    $gtk-pass-entry-buffer ?? self.bless( :$gtk-pass-entry-buffer ) !! Nil;
  }

}


### /usr/src/gtk4/gtk/gtkpasswordentrybuffer.h

sub gtk_password_entry_buffer_new
  returns GtkPasswordEntryBuffer
  is      native(gtk4)
  is      export
{ * }
