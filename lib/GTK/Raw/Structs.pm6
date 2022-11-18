use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use Pango::Raw::Definitions;
use Pango::Raw::Enums;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GTK::Raw::Definitions:ver<4>;
use GTK::Raw::Enums:ver<4>;

unit package GTK::Raw::Structs:ver<4>;

class GtkWidget is repr<CStruct> is export {
	HAS GInitiallyUnowned $!parent_instance;
	has gpointer          $!priv           ;
}

class BindingExpressionInfo is repr<CStruct> is export {
	has guint          $!tag_type    ;
	has GObject        $!target      ;
	has GParamSpec     $!target_pspec;
	has Str           $!object_name ;
	has ExpressionInfo $!expr        ;
	has int            $!line        ;
	has int            $!col         ;
}

class BindingInfo is repr<CStruct> is export {
	has guint         $!tag_type       ;
	has GObject       $!target         ;
	has GParamSpec    $!target_pspec   ;
	has Str          $!source         ;
	has Str          $!source_property;
	has GBindingFlags $!flags          ;
	has int           $!line           ;
	has int           $!col            ;
}

class CacheInfo is repr<CStruct> is export {
	has Str    $!cache        ;
	has gsize   $!cache_size   ;
	has guint32 $!n_directories;
	has int     $!flags        ;
}

class CachedSizeX is repr<CStruct> is export {
	has int $!minimum_size;
	has int $!natural_size;
}

class CachedSizeY is repr<CStruct> is export {
	has int $!minimum_size    ;
	has int $!natural_size    ;
	has int $!minimum_baseline;
	has int $!natural_baseline;
}

class ChildInfo is repr<CStruct> is export {
	has guint      $!tag_type          ;
	has GSList     $!packing_properties;
	has GObject    $!object            ;
	HAS CommonInfo $!parent            ;
	has Str       $!type              ;
	has Str       $!internal_child    ;
	has gboolean   $!added             ;
}

class CommonInfo is repr<CStruct> is export {
	has guint $!tag_type;
}

class GskPangoRendererClass is repr<CStruct> is export {
	HAS PangoRendererClass $!parent_class;
}

class GtkAccessibleValue is repr<CStruct> is export {
	has GtkAccessibleValueClass $!value_class;
	has int                     $!ref_count  ;
}

class GtkAdjustment is repr<CStruct> is export {
	HAS GInitiallyUnowned $!parent_instance;
}

class GtkApplication is repr<CStruct> is export {
	HAS GApplication $!parent_instance;
}

class GtkApplicationImpl is repr<CStruct> is export {
	HAS GObject        $!parent_instance;
	has GtkApplication $!application    ;
	has GdkDisplay     $!display        ;
}

class GtkApplicationImplDBus is repr<CStruct> is export {
	has GtkApplicationImpl $!impl                 ;
	has GDBusConnection    $!session              ;
	has Str               $!application_id       ;
	has Str               $!unique_name          ;
	has Str               $!object_path          ;
	has Str               $!app_menu_path        ;
	has guint              $!app_menu_id          ;
	has Str               $!menubar_path         ;
	has guint              $!menubar_id           ;
	has GDBusProxy         $!sm_proxy             ;
	has GDBusProxy         $!client_proxy         ;
	has Str               $!client_path          ;
	has GDBusProxy         $!ss_proxy             ;
	has GDBusProxy         $!inhibit_proxy        ;
	has GSList             $!inhibit_handles      ;
	has guint              $!state_changed_handler;
	has Str               $!session_id           ;
	has guint              $!session_state        ;
}

class GtkApplicationWindow is repr<CStruct> is export {
	HAS GtkWindow $!parent_instance;
}

class GtkApplicationWindowClass is repr<CStruct> is export {
	HAS GtkWindowClass $!parent_class;
	has gpointer       $!padding     ;
}

class GtkBookmark is repr<CStruct> is export {
	has GFile $!file ;
	has Str  $!label;
}

class GtkBookmarksManager is repr<CStruct> is export {
	has GSList                  $!bookmarks                   ;
	has GFileMonitor            $!bookmarks_monitor           ;
	has gulong                  $!bookmarks_monitor_changed_id;
	has gpointer                $!changed_func_data           ;
	has GtkBookmarksChangedFunc $!changed_func                ;
	has GCancellable            $!cancellable                 ;
}

class GtkBorder is repr<CStruct> is export {
	has gint16 $.left   is rw;
	has gint16 $.right  is rw;
	has gint16 $.top    is rw;
	has gint16 $.bottom is rw;
}

class GtkBox is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkBoxClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
	has gpointer       $!padding     ;
}

class GtkBuildableParseContext is repr<CStruct> is export {
	has GMarkupParser       $!internal_callbacks;
	has GMarkupParseContext $!ctx               ;
	has GtkBuildableParser  $!parser            ;
	has gpointer            $!user_data         ;
	has GPtrArray           $!tag_stack         ;
	has GArray              $!subparser_stack   ;
	has gpointer            $!held_user_data    ;
	has gboolean            $!awaiting_pop      ;
}

class GtkBuilderCScopeClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class GtkButton is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkCellArea is repr<CStruct> is export {
	HAS GInitiallyUnowned $!parent_instance;
}

class GtkCellAreaBoxAllocation is repr<CStruct> is export {
	has int $!group_idx;
	has int $!position ;
	has int $!size     ;
}

class GtkCellAreaBoxContext is repr<CStruct> is export {
	HAS GtkCellAreaContext           $!parent_instance;
	has gpointer $!priv           ;
}

class GtkCellAreaBoxContextClass is repr<CStruct> is export {
	HAS GtkCellAreaContextClass $!parent_class;
}

class GtkCellAreaContext is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkCellRenderer is repr<CStruct> is export {
	HAS GInitiallyUnowned      $!parent_instance;
	has gpointer $!priv           ;
}

class GtkCellRendererGraph is repr<CStruct> is export {
	has GtkCellRenderer             $!parent;
	has gpointer $!priv  ;
}

class GtkCellRendererText is repr<CStruct> is export {
	HAS GtkCellRenderer $!parent;
}

class GtkCheckButton is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkComboBox is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkComposeTable is repr<CStruct> is export {
	has guint16 $!data        ;
	has Str    $!char_data   ;
	has int     $!max_seq_len ;
	has int     $!n_index_size;
	has int     $!data_size   ;
	has int     $!n_chars     ;
	has int     $!n_sequences ;
	has guint32 $!id          ;
}

class GtkConstraintExpressionBuilder is repr<CStruct> is export {
	has gpointer $!dummy1;
	has gpointer $!dummy2;
	has int      $!dummy3;
}

class GtkConstraintExpressionIter is repr<CStruct> is export {
	has gpointer $!dummy1;
	has gpointer $!dummy2;
	has gint64   $!dummy3;
}

class GtkConstraintVariablePair is repr<CStruct> is export {
	has GtkConstraintVariable $!first ;
	has GtkConstraintVariable $!second;
}

class GtkConstraintVariableSetIter is repr<CStruct> is export {
	has gpointer $!dummy1;
	has gpointer $!dummy2;
	has gint64   $!dummy3;
}

class GtkConstraintVfl is repr<CStruct> is export {
	has Str                  $!view1     ;
	has Str                  $!attr1     ;
	has GtkConstraintRelation $!relation  ;
	has Str                  $!view2     ;
	has Str                  $!attr2     ;
	has gdouble                $!constant  ;
	has gdouble                $!multiplier;
	has gdouble                $!strength  ;
}

class GtkCrossingData is repr<CStruct> is export {
	has GtkCrossingType      $!type          ;
	has GtkCrossingDirection $!direction     ;
	has GdkCrossingMode      $!mode          ;
	has GtkWidget            $!old_target    ;
	has GtkWidget            $!old_descendent;
	has GtkWidget            $!new_target    ;
	has GtkWidget            $!new_descendent;
	has GdkDrop              $!drop          ;
}

class GtkCssAnimatedStyle is repr<CStruct> is export {
	HAS GtkCssStyle $!parent      ;
	has GtkCssStyle $!style       ;
	has gint64      $!current_time;
	has gpointer    $!animations  ;
	has guint       $!n_animations;
}

class GtkCssAnimatedStyleClass is repr<CStruct> is export {
	HAS GtkCssStyleClass $!parent_class;
}

class GtkCssAnimation is repr<CStruct> is export {
	has GtkStyleAnimation  $!parent    ;
	has Str               $!name      ;
	has GtkCssKeyframes    $!keyframes ;
	has GtkCssValue        $!ease      ;
	has GtkCssDirection    $!direction ;
	has GtkCssPlayState    $!play_state;
	has GtkCssFillMode     $!fill_mode ;
	has GtkProgressTracker $!tracker   ;
}

class GtkCssAnimationClass is repr<CStruct> is export {
	HAS GtkStyleAnimationClass $!parent_class;
}

class GtkCssAnimationValues is repr<CStruct> is export {
	has GtkCssValues $!base                     ;
	has GtkCssValue  $!animation_name           ;
	has GtkCssValue  $!animation_duration       ;
	has GtkCssValue  $!animation_timing_function;
	has GtkCssValue  $!animation_iteration_count;
	has GtkCssValue  $!animation_direction      ;
	has GtkCssValue  $!animation_play_state     ;
	has GtkCssValue  $!animation_delay          ;
	has GtkCssValue  $!animation_fill_mode      ;
}

class GtkCssBackgroundValues is repr<CStruct> is export {
	has GtkCssValues $!base                 ;
	has GtkCssValue  $!background_color     ;
	has GtkCssValue  $!box_shadow           ;
	has GtkCssValue  $!background_clip      ;
	has GtkCssValue  $!background_origin    ;
	has GtkCssValue  $!background_size      ;
	has GtkCssValue  $!background_position  ;
	has GtkCssValue  $!background_repeat    ;
	has GtkCssValue  $!background_image     ;
	has GtkCssValue  $!background_blend_mode;
}

class GtkCssCoreValues is repr<CStruct> is export {
	has GtkCssValues $!base        ;
	has GtkCssValue  $!color       ;
	has GtkCssValue  $!dpi         ;
	has GtkCssValue  $!font_size   ;
	has GtkCssValue  $!icon_palette;
}

class GtkCssDelimToken is repr<CStruct> is export {
	has GtkCssTokenType $!type ;
	has gunichar        $!delim;
}

class GtkCssDimensionToken is repr<CStruct> is export {
	has GtkCssTokenType $!type     ;
	has gdouble          $!value    ;
	has Str            $!dimension;
}

class GtkCssIconValues is repr<CStruct> is export {
	has GtkCssValues $!base       ;
	has GtkCssValue  $!icon_size  ;
	has GtkCssValue  $!icon_shadow;
	has GtkCssValue  $!icon_style ;
}

class GtkCssImage is repr<CStruct> is export {
	HAS GObject $!parent;
}

class GtkCssImageConic is repr<CStruct> is export {
	has GtkCssImage               $!parent     ;
	has GtkCssValue               $!center     ;
	has GtkCssValue               $!rotation   ;
	has guint                     $!n_stops    ;
	has GtkCssImageConicColorStop $!color_stops;
}

class GtkCssImageConicClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageConicColorStop is repr<CStruct> is export {
	has GtkCssValue $!offset;
	has GtkCssValue $!color ;
}

class GtkCssImageCrossFade is repr<CStruct> is export {
	HAS GtkCssImage $!parent        ;
	has GArray      $!images        ;
	has gdouble      $!total_progress;
}

class GtkCssImageCrossFadeClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageFallback is repr<CStruct> is export {
	HAS GtkCssImage $!parent  ;
	has GtkCssImage $!images  ;
	has int         $!n_images;
	has int         $!used    ;
	has GtkCssValue $!color   ;
}

class GtkCssImageFallbackClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageIconTheme is repr<CStruct> is export {
	has GtkCssImage      $!parent         ;
	has GtkIconTheme     $!icon_theme     ;
	has GdkRGBA          $!colors         ;
	has int              $!serial         ;
	has int              $!scale          ;
	has Str             $!name           ;
	has int              $!cached_size    ;
	has gboolean         $!cached_symbolic;
	has GtkIconPaintable $!cached_icon    ;
}

class GtkCssImageIconThemeClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageInvalid is repr<CStruct> is export {
	HAS GtkCssImage $!parent      ;
	has GFile       $!file        ;
	has GtkCssImage $!loaded_image;
}

class GtkCssImageInvalidClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageLinearClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageLinearColorStop is repr<CStruct> is export {
	has GtkCssValue $!offset;
	has GtkCssValue $!color ;
}

class GtkCssImagePaintable is repr<CStruct> is export {
	has GtkCssImage  $!parent          ;
	has GdkPaintable $!paintable       ;
	has GdkPaintable $!static_paintable;
}

class GtkCssImagePaintableClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageRadialClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageRadialColorStop is repr<CStruct> is export {
	has GtkCssValue $!offset;
	has GtkCssValue $!color ;
}

class GtkCssImageRecolor is repr<CStruct> is export {
	HAS GtkCssImage $!parent ;
	has GFile       $!file   ;
	has GtkCssValue $!palette;
	has GdkTexture  $!texture;
	has GdkRGBA     $!color  ;
	has GdkRGBA     $!success;
	has GdkRGBA     $!warning;
	has GdkRGBA     $!error  ;
}

class GtkCssImageRecolorClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageScaled is repr<CStruct> is export {
	HAS GtkCssImage $!parent  ;
	has GtkCssImage $!images  ;
	has int         $!n_images;
	has int         $!scales  ;
}

class GtkCssImageScaledClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssImageUrl is repr<CStruct> is export {
	HAS GtkCssImage $!parent      ;
	has GFile       $!file        ;
	has GtkCssImage $!loaded_image;
}

class GtkCssImageUrlClass is repr<CStruct> is export {
	HAS GtkCssImageClass $!parent_class;
}

class GtkCssLocation is repr<CStruct> is export {
	has gsize $!bytes     ;
	has gsize $!chars     ;
	has gsize $!lines     ;
	has gsize $!line_bytes;
	has gsize $!line_chars;
}

class GtkCssLookupValue is repr<CStruct> is export {
	has GtkCssSection $!section;
	has GtkCssValue   $!value  ;
}

class GtkCssNumberToken is repr<CStruct> is export {
	has GtkCssTokenType $!type  ;
	has gdouble          $!number;
}

class GtkCssOtherValues is repr<CStruct> is export {
	has GtkCssValues $!base            ;
	has GtkCssValue  $!icon_source     ;
	has GtkCssValue  $!icon_transform  ;
	has GtkCssValue  $!icon_filter     ;
	has GtkCssValue  $!transform       ;
	has GtkCssValue  $!transform_origin;
	has GtkCssValue  $!opacity         ;
	has GtkCssValue  $!filter          ;
}

class GtkCssProvider is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkCssShorthandProperty is repr<CStruct> is export {
	has GtkStyleProperty                 $!parent       ;
	has GPtrArray                        $!subproperties;
	has GtkCssShorthandPropertyParseFunc $!parse        ;
}

class GtkCssShorthandPropertyClass is repr<CStruct> is export {
	HAS GtkStylePropertyClass $!parent_class;
}

class GtkCssSizeValues is repr<CStruct> is export {
	has GtkCssValues $!base          ;
	has GtkCssValue  $!margin_top    ;
	has GtkCssValue  $!margin_left   ;
	has GtkCssValue  $!margin_bottom ;
	has GtkCssValue  $!margin_right  ;
	has GtkCssValue  $!padding_top   ;
	has GtkCssValue  $!padding_left  ;
	has GtkCssValue  $!padding_bottom;
	has GtkCssValue  $!padding_right ;
	has GtkCssValue  $!border_spacing;
	has GtkCssValue  $!min_width     ;
	has GtkCssValue  $!min_height    ;
}

class GtkCssStaticStyle is repr<CStruct> is export {
	has GtkCssStyle  $!parent  ;
	has GPtrArray    $!sections;
	has GtkCssChange $!change  ;
}

class GtkCssStaticStyleClass is repr<CStruct> is export {
	HAS GtkCssStyleClass $!parent_class;
}

class GtkCssStringToken is repr<CStruct> is export {
	has GtkCssTokenType $!type  ;
	has Str            $!string;
}

class GtkCssStyle is repr<CStruct> is export {
	has GObject                 $!parent      ;
	has GtkCssCoreValues        $!core        ;
	has GtkCssBackgroundValues  $!background  ;
	has GtkCssBorderValues      $!border      ;
	has GtkCssIconValues        $!icon        ;
	has GtkCssOutlineValues     $!outline     ;
	has GtkCssFontValues        $!font        ;
	has GtkCssFontVariantValues $!font_variant;
	has GtkCssAnimationValues   $!animation   ;
	has GtkCssTransitionValues  $!transition  ;
	has GtkCssSizeValues        $!size        ;
	has GtkCssOtherValues       $!other       ;
}

class GtkCssStyleChange is repr<CStruct> is export {
	has GtkCssStyle   $!old_style;
	has GtkCssStyle   $!new_style;
	has GtkCssAffects $!affects  ;
	has GtkBitmask    $!changes  ;
}

class GtkCssStylePropertyClass is repr<CStruct> is export {
	HAS GtkStylePropertyClass $!parent_class    ;
	has GPtrArray             $!style_properties;
}

class GtkCssTransientNode is repr<CStruct> is export {
	has GtkCssNode $!node;
}

class GtkCssTransientNodeClass is repr<CStruct> is export {
	has GtkCssNodeClass $!node_class;
}

class GtkCssTransitionClass is repr<CStruct> is export {
	HAS GtkStyleAnimationClass $!parent_class;
}

class GtkCssTransitionValues is repr<CStruct> is export {
	has GtkCssValues $!base                      ;
	has GtkCssValue  $!transition_property       ;
	has GtkCssValue  $!transition_duration       ;
	has GtkCssValue  $!transition_timing_function;
	has GtkCssValue  $!transition_delay          ;
}

class GtkCssValues is repr<CStruct> is export {
	has int              $!ref_count;
	has GtkCssValuesType $!type     ;
}

class GtkCssWidgetNode is repr<CStruct> is export {
	has GtkCssNode  $!node              ;
	has GtkWidget   $!widget            ;
	has guint       $!validate_cb_id    ;
	has GtkCssStyle $!last_updated_style;
}

class GtkCssWidgetNodeClass is repr<CStruct> is export {
	has GtkCssNodeClass $!node_class;
}

class GtkDialog is repr<CStruct> is export {
	HAS GtkWindow $!parent_instance;
}

class GtkDrawingArea is repr<CStruct> is export {
	has GtkWidget $!widget;
}

class GtkEntry is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkEntryBuffer is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkEventController is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkFileChooserErrorStack is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
	has GtkWidget $!stack          ;
}

class GtkFileChooserErrorStackClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
}

class GtkFileChooserNative is repr<CStruct> is export {
	HAS GtkNativeDialog $!parent_instance;
	has Str            $!accept_label   ;
	has Str            $!cancel_label   ;
	has int             $!mode           ;
	has GSList          $!custom_files   ;
	has GFile           $!current_folder ;
	has GFile           $!current_file   ;
	has Str            $!current_name   ;
	has GtkFileFilter   $!current_filter ;
	has GSList          $!choices        ;
	has GtkWidget       $!dialog         ;
	has GtkWidget       $!accept_button  ;
	has GtkWidget       $!cancel_button  ;
	has gpointer        $!mode_data      ;
}

class GtkFileChooserNativeChoice is repr<CStruct> is export {
	has Str $!id           ;
	has Str $!label        ;
	has Str $!options      ;
	has Str $!option_labels;
	has Str $!selected     ;
}

class GtkFixed is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkFixedClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
	has gpointer       $!padding     ;
}

class GtkFlowBoxChild is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkFrame is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkGLArea is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkGesture is repr<CStruct> is export {
	HAS GtkEventController $!parent_instance;
}

class GtkGestureClick is repr<CStruct> is export {
	HAS GtkGestureSingle $!parent_instance;
}

class GtkGestureDrag is repr<CStruct> is export {
	HAS GtkGestureSingle $!parent_instance;
}

class GtkGestureLongPress is repr<CStruct> is export {
	HAS GtkGestureSingle $!parent_instance;
}

class GtkGesturePan is repr<CStruct> is export {
	HAS GtkGestureDrag $!parent_instance;
}

class GtkGestureRotate is repr<CStruct> is export {
	HAS GtkGesture $!parent_instance;
}

class GtkGestureSingle is repr<CStruct> is export {
	HAS GtkGesture $!parent_instance;
}

class GtkGestureStylus is repr<CStruct> is export {
	HAS GtkGestureSingle $!parent_instance;
}

class GtkGestureSwipe is repr<CStruct> is export {
	HAS GtkGestureSingle $!parent_instance;
}

class GtkGestureZoom is repr<CStruct> is export {
	HAS GtkGesture $!parent_instance;
}

class GtkGizmo is repr<CStruct> is export {
	HAS GtkWidget             $!parent_instance;
	has GtkGizmoMeasureFunc   $!measure_func   ;
	has GtkGizmoAllocateFunc  $!allocate_func  ;
	has GtkGizmoSnapshotFunc  $!snapshot_func  ;
	has GtkGizmoContainsFunc  $!contains_func  ;
	has GtkGizmoFocusFunc     $!focus_func     ;
	has GtkGizmoGrabFocusFunc $!grab_focus_func;
}

class GtkGizmoClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
}

class GtkGraphData is repr<CStruct> is export {
	has GObject             $!object;
	has gpointer $!priv  ;
}

class GtkGrid is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkGridClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
	has gpointer       $!padding     ;
}

class GtkIMContext is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkIMContextIMEClass is repr<CStruct> is export {
	HAS GtkIMContextClass $!parent_class;
}

class GtkIMContextSimple is repr<CStruct> is export {
	has GtkIMContext              $!object;
	has gpointer $!priv  ;
}

class GtkIMContextSimpleClass is repr<CStruct> is export {
	HAS GtkIMContextClass $!parent_class;
}

class GtkIMMulticontext is repr<CStruct> is export {
	has GtkIMContext             $!object;
	has gpointer $!priv  ;
}

class GtkIconView is repr<CStruct> is export {
	has GtkWidget          $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorCssEditor is repr<CStruct> is export {
	has GtkBox                       $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorCssEditorClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent;
}

class GtkInspectorCssNodeTree is repr<CStruct> is export {
	has GtkBox                         $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorCssNodeTreeClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent;
}

class GtkInspectorEventRecording is repr<CStruct> is export {
	HAS GtkInspectorRecording $!parent;
	has GdkEvent              $!event ;
}

class GtkInspectorEventRecordingClass is repr<CStruct> is export {
	HAS GtkInspectorRecordingClass $!parent;
}

class GtkInspectorMagnifier is repr<CStruct> is export {
	has GtkBox                       $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorMagnifierClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent;
}

class GtkInspectorMenu is repr<CStruct> is export {
	has GtkBox                  $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorMenuClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent;
}

class GtkInspectorObjectTree is repr<CStruct> is export {
	has GtkBox                        $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorPropList is repr<CStruct> is export {
	has GtkBox                      $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorPropListClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent;
}

class GtkInspectorRecording is repr<CStruct> is export {
	HAS GObject $!parent   ;
	has gint64  $!timestamp;
}

class GtkInspectorRecordingClass is repr<CStruct> is export {
	HAS GObjectClass $!parent;
}

class GtkInspectorRenderRecording is repr<CStruct> is export {
	HAS GtkInspectorRecording $!parent       ;
	has GdkRectangle          $!area         ;
	has cairo_region_t        $!clip_region  ;
	has GskRenderNode         $!node         ;
	has Str                  $!profiler_info;
}

class GtkInspectorRenderRecordingClass is repr<CStruct> is export {
	HAS GtkInspectorRecordingClass $!parent;
}

class GtkInspectorSizeGroups is repr<CStruct> is export {
	HAS GtkBox $!parent;
}

class GtkInspectorSizeGroupsClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent;
}

class GtkInspectorStartRecording is repr<CStruct> is export {
	HAS GtkInspectorRecording $!parent;
}

class GtkInspectorStartRecordingClass is repr<CStruct> is export {
	HAS GtkInspectorRecordingClass $!parent;
}

class GtkInspectorStatistics is repr<CStruct> is export {
	has GtkBox                        $!parent;
	has gpointer $!priv  ;
}

class GtkInspectorStatisticsClass is repr<CStruct> is export {
	HAS GtkBoxClass $!parent;
}

class GtkInspectorStrvEditor is repr<CStruct> is export {
	has GtkBox    $!parent ;
	has GtkWidget $!box    ;
	has GtkWidget $!button ;
	has gboolean  $!blocked;
}

class GtkInspectorWindow is repr<CStruct> is export {
	has GtkWindow           $!parent               ;
	has GtkWidget           $!top_stack            ;
	has GtkWidget           $!object_stack         ;
	has GtkWidget           $!button_stack         ;
	has GtkWidget           $!object_tree          ;
	has GtkWidget           $!object_id            ;
	has GtkWidget           $!object_details       ;
	has GtkWidget           $!object_buttons       ;
	has GtkWidget           $!object_details_button;
	has GtkWidget           $!select_object        ;
	has GtkWidget           $!object_start_stack   ;
	has GtkWidget           $!object_center_stack  ;
	has GtkWidget           $!object_title         ;
	has GtkWidget           $!prop_list            ;
	has GtkWidget           $!layout_prop_list     ;
	has GtkWidget           $!selector             ;
	has GtkWidget           $!signals_list         ;
	has GtkWidget           $!classes_list         ;
	has GtkWidget           $!widget_css_node_tree ;
	has GtkWidget           $!widget_recorder      ;
	has GtkWidget           $!object_hierarchy     ;
	has GtkWidget           $!size_groups          ;
	has GtkWidget           $!tree_data            ;
	has GtkWidget           $!list_data            ;
	has GtkWidget           $!actions              ;
	has GtkWidget           $!shortcuts            ;
	has GtkWidget           $!menu                 ;
	has GtkWidget           $!misc_info            ;
	has GtkWidget           $!controllers          ;
	has GtkWidget           $!magnifier            ;
	has GtkWidget           $!a11y                 ;
	has GtkWidget           $!sidebar_revealer     ;
	has GtkWidget           $!css_editor           ;
	has GtkWidget           $!visual               ;
	has GtkWidget           $!clipboard            ;
	has GtkWidget           $!general              ;
	has GtkWidget           $!logs                 ;
	has GtkWidget           $!go_up_button         ;
	has GtkWidget           $!go_down_button       ;
	has GtkWidget           $!go_previous_button   ;
	has GtkWidget           $!list_position_label  ;
	has GtkWidget           $!go_next_button       ;
	has GList               $!extra_pages          ;
	has GdkSeat             $!grab_seat            ;
	has GtkInspectorOverlay $!flash_overlay        ;
	has int                 $!flash_count          ;
	has int                 $!flash_cnx            ;
	has GArray              $!objects              ;
	has GList               $!overlays             ;
	has GdkDisplay          $!inspected_display    ;
}

class GtkInspectorWindowClass is repr<CStruct> is export {
	HAS GtkWindowClass $!parent;
}

class GtkLayoutChildClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class GtkListBase is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkListBoxRow is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkListItemFactory is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkListItemManagerItem is repr<CStruct> is export {
	has GtkWidget $!widget ;
	has guint     $!n_items;
}

class GtkListItemManagerItemAugment is repr<CStruct> is export {
	has guint $!n_items;
}

class GtkListItemWidget is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkListStore is repr<CStruct> is export {
	has GObject             $!parent;
	has gpointer $!priv  ;
}

class GtkListStoreClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
	has gpointer     $!padding     ;
}

class GtkListView is repr<CStruct> is export {
	HAS GtkListBase        $!parent_instance;
	has GtkListItemManager $!item_manager   ;
	has gboolean           $!show_separators;
	has int                $!list_width     ;
}

class GtkListViewClass is repr<CStruct> is export {
	HAS GtkListBaseClass $!parent_class;
}

class GtkMessageDialog is repr<CStruct> is export {
	HAS GtkDialog $!parent_instance;
}

class GtkMountOperation is repr<CStruct> is export {
	HAS GMountOperation          $!parent_instance;
	has gpointer $!priv           ;
}

class GtkOrientableIface is repr<CStruct> is export {
	has GTypeInterface $!base_iface;
}

class GtkPadActionEntry is repr<CStruct> is export {
	has GtkPadActionType $!type       ;
	has int              $!index      ;
	has int              $!mode       ;
	has Str             $!label      ;
	has Str             $!action_name;
}

class GtkPageRange is repr<CStruct> is export {
	has int $!start;
	has int $!end  ;
}

class GtkPanedHandle is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkPanedHandleClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
}

class GtkPangoAttributeParserData is repr<CStruct> is export {
	has GtkBuilder    $!builder;
	has GObject       $!object ;
	has PangoAttrList $!attrs  ;
}

class GtkParamSpecExpression is repr<CStruct> is export {
	HAS GParamSpec $!parent_instance;
}

class GtkPointerFocus is repr<CStruct> is export {
	has int              $!ref_count  ;
	has GdkDevice        $!device     ;
	has GdkEventSequence $!sequence   ;
	has GtkWindow        $!toplevel   ;
	has GtkWidget        $!target     ;
	has GtkWidget        $!grab_widget;
	has gdouble           $!x          ;
	has gdouble           $!y          ;
}

class GtkPopover is repr<CStruct> is export {
	HAS GtkWidget $!parent;
}

class GtkPopoverContent is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkPopoverContentClass is repr<CStruct> is export {
	HAS GtkWidgetClass $!parent_class;
}

class GtkPrintBackend is repr<CStruct> is export {
	HAS GObject                $!parent_instance;
	has gpointer $!priv           ;
}

class GtkPrintOperation is repr<CStruct> is export {
	HAS GObject                  $!parent_instance;
	has gpointer $!priv           ;
}

class GtkPrinter is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkPrinterOption is repr<CStruct> is export {
	HAS GObject              $!parent_instance  ;
	has Str                 $!name             ;
	has Str                 $!display_text     ;
	has GtkPrinterOptionType $!type             ;
	has Str                 $!value            ;
	has int                  $!num_choices      ;
	has Str                 $!choices          ;
	has Str                 $!choices_display  ;
	has gboolean             $!activates_default;
	has gboolean             $!has_conflict     ;
	has Str                 $!group            ;
}

class GtkPrinterOptionSet is repr<CStruct> is export {
	HAS GObject    $!parent_instance;
	has GPtrArray  $!array          ;
	has GHashTable $!hash           ;
}

class GtkPrinterOptionWidget is repr<CStruct> is export {
	HAS GtkBox                        $!parent_instance;
	has gpointer $!priv           ;
}

class GtkProgressTracker is repr<CStruct> is export {
	has guint64  $!last_frame_time;
	has guint64  $!duration       ;
	has gdouble   $!iteration      ;
	has gdouble   $!iteration_count;
	has gboolean $!is_running     ;
}

class GtkQuery is repr<CStruct> is export {
	HAS GObject $!parent;
}

class GtkQueryClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class GtkRange is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkRecentData is repr<CStruct> is export {
	has Str     $!display_name;
	has Str     $!description ;
	has Str     $!mime_type   ;
	has Str     $!app_name    ;
	has Str     $!app_exec    ;
	has Str     $!groups      ;
	has gboolean $!is_private  ;
}

class GtkRecentManager is repr<CStruct> is export {
	HAS GObject                 $!parent_instance;
	has gpointer $!priv           ;
}

class GtkRequestedSize is repr<CStruct> is export {
	has gpointer $!data        ;
	has int      $!minimum_size;
	has int      $!natural_size;
}

class GtkRequisition is repr<CStruct> is export {
	has int $!width ;
	has int $!height;
}

class GtkScale is repr<CStruct> is export {
	HAS GtkRange $!parent_instance;
}

class GtkScaleButton is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkSearchEngine is repr<CStruct> is export {
	has GObject                $!parent;
	has gpointer $!priv  ;
}

class GtkSearchEngineQuartz is repr<CStruct> is export {
	has GtkSearchEngine              $!parent;
	has gpointer $!priv  ;
}

class GtkSearchEngineQuartzClass is repr<CStruct> is export {
	HAS GtkSearchEngineClass $!parent_class;
}

class GtkSearchHit is repr<CStruct> is export {
	has GFile     $!file;
	has GFileInfo $!info;
}

class GtkSidebarRowClass is repr<CStruct> is export {
	HAS GtkListBoxRowClass $!parent;
}

class GtkSizeGroup is repr<CStruct> is export {
	HAS GObject $!parent_instance;
}

class GtkSortKeys is repr<CStruct> is export {
	has GtkSortKeysClass $!klass    ;
	has int              $!ref_count;
	has gsize            $!key_size ;
	has gsize            $!key_align;
}

class GtkStyleAnimation is repr<CStruct> is export {
	has GtkStyleAnimationClass $!class    ;
	has guint                  $!ref_count;
}

class GtkStyleCascade is repr<CStruct> is export {
	has GObject         $!object   ;
	HAS GtkStyleCascade $!parent   ;
	has GArray          $!providers;
	has int             $!scale    ;
}

class GtkStyleCascadeClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class GtkStyleContext is repr<CStruct> is export {
	HAS GObject $!parent_object;
}

class GtkStyleProperty is repr<CStruct> is export {
	HAS GObject $!parent;
	has Str    $!name  ;
}

class GtkText is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkTextAttrAppearance is repr<CStruct> is export {
	has PangoAttribute    $!attr      ;
	has GtkTextAppearance $!appearance;
}

class GtkTextBuffer is repr<CStruct> is export {
	HAS GObject              $!parent_instance;
	has gpointer $!priv           ;
}

class GtkTextChildAnchor is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!segment        ;
}

class GtkTextChildBody is repr<CStruct> is export {
	has GtkTextChildAnchor $!obj    ;
	has GSList             $!widgets;
	has GtkTextBTree       $!tree   ;
	has GtkTextLine        $!line   ;
}

class GtkTextIter is repr<CStruct> is export {
	has gpointer $!dummy1 ;
	has gpointer $!dummy2 ;
	has int      $!dummy3 ;
	has int      $!dummy4 ;
	has int      $!dummy5 ;
	has int      $!dummy6 ;
	has int      $!dummy7 ;
	has int      $!dummy8 ;
	has gpointer $!dummy9 ;
	has gpointer $!dummy10;
	has int      $!dummy11;
	has int      $!dummy12;
	has int      $!dummy13;
	has gpointer $!dummy14;
}

class GtkTextLayoutClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class GtkTextLine is repr<CStruct> is export {
	has GtkTextBTreeNode   $!parent                ;
	has GtkTextLine        $!next                  ;
	has GtkTextLineSegment $!segments              ;
	has GtkTextLineData    $!views                 ;
	has guchar             $!dir_strong            ;
	has guchar             $!dir_propagated_back   ;
	has guchar             $!dir_propagated_forward;
}

class GtkTextLineSegmentClass is repr<CStruct> is export {
	has Str                     $!name          ;
	has gboolean                 $!leftGravity   ;
	has GtkTextSegSplitFunc      $!splitFunc     ;
	has GtkTextSegDeleteFunc     $!deleteFunc    ;
	has GtkTextSegCleanupFunc    $!cleanupFunc   ;
	has GtkTextSegLineChangeFunc $!lineChangeFunc;
	has GtkTextSegCheckFunc      $!checkFunc     ;
}

class GtkTextMark is repr<CStruct> is export {
	HAS GObject  $!parent_instance;
	has gpointer $!segment        ;
}

class GtkTextMarkClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
	has gpointer     $!padding     ;
}

class GtkTextPaintable is repr<CStruct> is export {
	has GdkPaintable $!paintable;
	has GtkTextBTree $!tree     ;
	has GtkTextLine  $!line     ;
}

class GtkTextTag is repr<CStruct> is export {
	HAS GObject           $!parent_instance;
	has gpointer $!priv           ;
}

class GtkTextTagClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
	has gpointer     $!padding     ;
}

class GtkTextTagInfo is repr<CStruct> is export {
	has GtkTextTag       $!tag         ;
	has GtkTextBTreeNode $!tag_root    ;
	has int              $!toggle_count;
}

class GtkTextToggleBody is repr<CStruct> is export {
	has GtkTextTagInfo $!info        ;
	has gboolean       $!inNodeCounts;
}

class GtkTextView is repr<CStruct> is export {
	HAS GtkWidget          $!parent_instance;
	has gpointer $!priv           ;
}

class GtkTimSortRun is repr<CStruct> is export {
	has void  $!base;
	has gsize $!len ;
}

class GtkToggleButton is repr<CStruct> is export {
	has GtkButton $!button;
}

class GtkTreeDataSortHeader is repr<CStruct> is export {
	has int                    $!sort_column_id;
	has GtkTreeIterCompareFunc $!func          ;
	has gpointer               $!data          ;
	has GDestroyNotify         $!destroy       ;
}

class GtkTreeIter is repr<CStruct> is export {
	has int      $!stamp     ;
	has gpointer $!user_data ;
	has gpointer $!user_data2;
	has gpointer $!user_data3;
}

class GtkTreeModelCssNode is repr<CStruct> is export {
	has GObject                    $!parent;
	has gpointer $!priv  ;
}

class GtkTreeModelCssNodeClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
}

class GtkTreeModelFilter is repr<CStruct> is export {
	has GObject                   $!parent;
	has gpointer $!priv  ;
}

class GtkTreeModelSort is repr<CStruct> is export {
	has GObject                 $!parent;
	has gpointer $!priv  ;
}

class GtkTreeModelSortClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
	has gpointer     $!padding     ;
}

class GtkTreeRBTree is repr<CStruct> is export {
	has GtkTreeRBNode $!root       ;
	HAS GtkTreeRBTree $!parent_tree;
	HAS GtkTreeRBNode $!parent_node;
}

class GtkTreeStore is repr<CStruct> is export {
	has GObject             $!parent;
	has gpointer $!priv  ;
}

class GtkTreeStoreClass is repr<CStruct> is export {
	HAS GObjectClass $!parent_class;
	has gpointer     $!padding     ;
}

class GtkTreeView is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkVolumeButton is repr<CStruct> is export {
	HAS GtkScaleButton $!parent;
}

class GtkWidgetAction is repr<CStruct> is export {
	has GtkWidgetAction             $!next          ;
	has Str                        $!name          ;
	has GType                       $!owner         ;
	has GVariantType                $!parameter_type;
	has GtkWidgetActionActivateFunc $!activate      ;
	has GVariantType                $!state_type    ;
	has GParamSpec                  $!pspec         ;
}

class gpointer is repr<CStruct> is export {
	has GtkWidgetTemplate $!template           ;
	has GListStore        $!shortcuts          ;
	has GType             $!layout_manager_type;
	has GtkWidgetAction   $!actions            ;
	has GtkAccessibleRole $!accessible_role    ;
	has guint             $!activate_signal    ;
	has GQuark            $!css_name           ;
}

class GtkWidgetSurfaceTransformData is repr<CStruct> is export {
	has GtkWidget         $!tracked_parent                     ;
	HAS guint             $!parent_surface_transform_changed_id;
	has gboolean          $!cached_surface_transform_valid     ;
	has graphene_matrix_t $!cached_surface_transform           ;
	has GList             $!callbacks                          ;
}

class GtkWidgetTemplate is repr<CStruct> is export {
	has GBytes          $!data    ;
	has GSList          $!children;
	has GtkBuilderScope $!scope   ;
}

class GtkWindow is repr<CStruct> is export {
	HAS GtkWidget $!parent_instance;
}

class GtkWindowGroup is repr<CStruct> is export {
	HAS GObject               $!parent_instance;
	has gpointer $!priv           ;
}

class NamedTag is repr<CStruct> is export {
	has int  $!tag ;
	has Str $!name;
}

class ParserData is repr<CStruct> is export {
	has Str                     $!last_element           ;
	has GtkBuilder               $!builder                ;
	has Str                     $!domain                 ;
	has GPtrArray                $!stack                  ;
	has SubParser                $!subparser              ;
	has GtkBuildableParseContext $!ctx                    ;
	has Str                     $!filename               ;
	has GPtrArray                $!finalizers             ;
	has GSList                   $!custom_finalizers      ;
	has Str                     $!requested_objects      ;
	has gboolean                 $!inside_requested_object;
	has int                      $!requested_object_level ;
	has int                      $!cur_object_level       ;
	has int                      $!object_counter         ;
	has GHashTable               $!object_ids             ;
}

class RequiresInfo is repr<CStruct> is export {
	has guint $!tag_type;
	has Str  $!library ;
	has int   $!major   ;
	has int   $!minor   ;
}

class SignalInfo is repr<CStruct> is export {
	has guint         $!tag_type           ;
	has Str          $!object_name        ;
	has guint         $!id                 ;
	has GQuark        $!detail             ;
	has Str          $!handler            ;
	has GConnectFlags $!flags              ;
	has Str          $!connect_object_name;
}

class SizeRequestX is repr<CStruct> is export {
	has int         $!lower_for_size;
	has int         $!upper_for_size;
	has CachedSizeX $!cached_size   ;
}

class SizeRequestY is repr<CStruct> is export {
	has int         $!lower_for_size;
	has int         $!upper_for_size;
	has CachedSizeY $!cached_size   ;
}

class SubParser is repr<CStruct> is export {
	has GtkBuildableParser $!parser ;
	has Str               $!tagname;
	has Str               $!start  ;
	has gpointer           $!data   ;
	has GObject            $!object ;
	has GObject            $!child  ;
}

class array_container_s is repr<CStruct> is export {
	has int32_t  $!cardinality;
	has int32_t  $!capacity   ;
	has uint16_t $!array      ;
}

class bitset_container_s is repr<CStruct> is export {
	has int32_t  $!cardinality;
	has uint64_t $!array      ;
}

class closure is repr<CStruct> is export {
	has GType    $!type         ;
	has Str     $!function_name;
	has Str     $!object_name  ;
	has gboolean $!swapped      ;
	has GSList   $!params       ;
}

class constant is repr<CStruct> is export {
	has GType   $!type;
	has GString $!text;
}

class gtk_secure_rec is repr<CStruct> is export {
	has Str   $!tag           ;
	has size_t $!request_length;
	has size_t $!block_length  ;
}

class property is repr<CStruct> is export {
	has GType          $!this_type    ;
	has Str           $!property_name;
	has ExpressionInfo $!expression   ;
}

class roaring_array_t is repr<CStruct> is export {
	has int32_t  $!size           ;
	has int32_t  $!allocation_size;
	has void     $!containers     ;
	has uint16_t $!keys           ;
	has uint8_t  $!typecodes      ;
	has uint8_t  $!flags          ;
}

class roaring_bitmap_t is repr<CStruct> is export {
	has roaring_array_t $!high_low_container;
}

class run_container_s is repr<CStruct> is export {
	has int32_t $!n_runs  ;
	has int32_t $!capacity;
	has rle16_t $!runs    ;
}
