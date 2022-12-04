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

class GtkAccessible         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuildable          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuilderScope       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkConstraintTarget   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCssValue           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLayoutManager      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkNative             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkRoot               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSnapshot           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcut           is repr<CPointer> does GLib::Roles::Pointers is export { }

class GtkAboutDialog        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBitset             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBoxLayout          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuilder            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkBuildableParser    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCalendar           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkConstraint         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkConstraintVariable is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCssNode            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkCssSection         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkDirectoryList      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkDropDown           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEditable           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEmojiChooser       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkEntryCompletion    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkExpression         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkExpressionWatch    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFileFilter         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkFlowBox            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkGridView           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconPaintable      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkIconTheme          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkImage              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkInfoBar            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkInspectorOverlay   is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLabel              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkListItem           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkListItemManager    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkLayoutChild        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkMenuButton         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkNativeDialog       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkOrientable         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPaned              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkPicture            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkProgressBar        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSelectionModel     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScrollable         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScrollbar          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkScrolledWindow     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSeparator          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSettings           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcutController is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcutManager    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkShortcutsWindow    is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSpinner            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSpinButton         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStatusbar          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStringList         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStringObject       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkStyleProvider      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkSwitch             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTooltip            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeModel          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreePath           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GtkTreeRowReference   is repr<CPointer> does GLib::Roles::Pointers is export { }
