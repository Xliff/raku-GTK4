use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;

use GLib::Roles::Pointers;

unit package GTK::Raw::Definitions:ver<4>;

constant gtk4 is export = 'gtk-4';

constant GtkAllocation is export := GdkRectangle;
constant GtkCssChange  is export := guint64;

class GtkAccessible        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuildable         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuilderScope      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkConstraintTarget  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCssValue          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLayoutManager     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkNative            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRoot              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSnapshot          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcut          is repr<CPointer> does GLib::Roles::Pointers is export { }

class GtkBuilder            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuildableParser    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkConstraintVariable is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCssNode            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCssSection         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFileFilter         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconPaintable      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconTheme          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkInspectorOverlay   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkListItemManager    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkNativeDialog       is repr<CPointer> does GLib::Roles::Pointers is export { }
