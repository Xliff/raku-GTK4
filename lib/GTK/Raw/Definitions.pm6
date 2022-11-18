use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;

use GLib::Roles::Pointers;

unit package GTK::Raw::Definitions:ver<4>;

constant gtk4 is export = 'gtk-4';

constant GtkAllocation is export := GdkRectangle;

class GtkCssValue        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuilderScope    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEventController is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLayoutManager   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcut        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSnapshot        is repr<CPointer> does GLib::Roles::Pointers is export { }


# cw: To be removed
class GtkWidget          is repr<CPointer> does GLib::Roles::Pointers is export { }
