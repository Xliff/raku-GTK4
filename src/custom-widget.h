#include <gtk/gtk.h>

typedef void     (* GtkShowFunc)               (GtkCustomWidget *w);
typedef void     (* GtkHideFunc)               (GtkCustomWidget *w);
typedef void     (* GtkMapFunc)                (GtkCustomWidget *w);
typedef void     (* GtkUnmapFunc)              (GtkCustomWidget *w);
typedef void     (* GtkRealizeFunc)            (GtkCustomWidget *w);
typedef void     (* GtkUnrealizeFunc)          (GtkCustomWidget *w);
typedef void     (* GtkRootFunc)               (GtkCustomWidget *w);
typedef void     (* GtkUnrootFunc)             (GtkCustomWidget *w);
typedef void     (* GtkGetSizeRequestModeFunc) (GtkCustomWidget *w);

typedef gboolean (* GtkGrabFocusFunc)          (GtkCustomWidget  *w);

typedef void     (* GtkSnapshotFunc) (GtkCustomWidget *w, GtkSnapshot *s);
typedef gboolean (* GtkContainsFunc) (GtkCustomWidget *w, double x, double y);

typedef void     (* GtkSizeAllocateFunc) (
  GtkCustomWidget *w,
  int              width,
  int              height,
  int              baseline
);

typedef void (* GtkStateFlagsChangedFunc)         (GtkCustomWidget *w,
                                                   GtkStateFlags    prev_flags);

typedef void (* GdkDirectionChangedFunc)          (GtkCustomWidget *w,
                                                   GtkTextDirection  prevdir);

typedef void (* GtkMeasureFunc)                   (GtkCustomWidget *w,
                                                   GtkOrientation   o,
                                                   int              f,
                                                   int             *m,
                                                   int             *n,
                                                   int             *m_baseline,
                                                   int             *n_baseline);

typedef gboolean (* GtkMnemonicActivateFunc)       (GtkCustomWidget *w,
                                                    gboolean         g);

typedef gboolean (* GtkFocusFunc)                  (GtkCustomWidget  *w,
                                                    GtkDirectionType d);

typedef void     (* GtkSetFocusChildFunc)          (GtkCustomWidget  *w,
                                                    GtkWidget        *c);

typedef void     (* GtkMoveFocusFunc)              (GtkCustomWidget  *w,
                                                    GtkDirectionType  d);

typedef void     (* GtkKeynavFailedFunc)           (GtkCustomWidget  *w,
                                                    GtkDirectionType  d);

typedef gboolean (* GtkQueryTooltipFunc)           (GtkWidget  *w,
                                                    int         x,
                                                    int         y,
                                                    gboolean    key_tooltip,
                                                    GtkTooltip *tooltip);

typedef void      (* GtkComputeExpandFunc)         (GtkWidget  *w,
                                                    gboolean   *hexpand_p,
                                                    gboolean   *vexpand_p);

typedef void      (* GtkCssChangedFunc)            (GtkWidget         *w,
                                                    GtkCssStyleChange *c);

typedef void      (* GtkSystemSettingsChangedFunc) (GtkWidget       *w,
                                                    GtkSystemSetting s);


GtkCustomWidget *gtk_custom_widget_new (void);

void gtk_custom_widget_set_show_func      (GtkCustomWidget *w, GtkShowFunc      *func);
void gtk_custom_widget_set_hide_func      (GtkCustomWidget *w, GtkHideFunc      *func);
void gtk_custom_widget_set_map_func       (GtkCustomWidget *w, GtkMapFunc       *func);
void gtk_custom_widget_set_unmap_func     (GtkCustomWidget *w, GtkUnmapFunc     *func);
void gtk_custom_widget_set_realize_func   (GtkCustomWidget *w, GtkRealizeFunc   *func);
void gtk_custom_widget_set_unrealize_func (GtkCustomWidget *w, GtkUnrealizeFunc *func);
void gtk_custom_widget_set_root_func      (GtkCustomWidget *w, GtkRootFunc      *func);
void gtk_custom_widget_set_unroot_func    (GtkCustomWidget *w, GtkUnrootFunc    *func);
void gtk_custom_widget_set_snapshot_func  (GtkCustomWidget *w, GtkSnapshotFunc  *func);
void gtk_custom_widget_set_contains_func  (GtkCustomWidget *w, GtkContainsFunc  *func);
void gtk_custom_widget_set_measure_func   (GtkCustomWidget *w, GtkMeasureFunc   *func);
void gtk_custom_widget_set_focus_func     (GtkCustomWidget *w, GtkFocusFunc     *func);

void gtk_custom_widget_set_size_allocate_func (
  GtkCustomWidget              *w,
  GtkSizeAllocateFunc          *func
);

void gtk_custom_widget_set_state_flags_changed_func (
  GtkCustomWidget              *w,
  GtkStateFlagsChangedFunc     *func
);

void gtk_custom_widget_set_gdk_set_direction_changed_func (
  GtkCustomWidget              *w,
  GdkDirectionChangedFunc      *func
);

void gtk_custom_widget_set_get_size_request_mode_func (
  GtkCustomWidget              *w,
  GtkGetSizeRequestModeFunc    *func
);

void gtk_custom_widget_set_mnemonic_activate_func (
  GtkCustomWidget              *w,
  GtkMnemonicActivateFunc      *func
);

void gtk_custom_widget_set_grab_focus_func (
  GtkCustomWidget              *w,
  GtkGrabFocusFunc             *func
);

void gtk_custom_widget_set_set_focus_child_func (
  GtkCustomWidget              *w,
  GtkSetFocusChildFunc         *func
);

void gtk_custom_widget_set_move_focus_func (
  GtkCustomWidget              *w,
  GtkMoveFocusFunc             *func
);

void gtk_custom_widget_set_keynav_failed_func (
  GtkCustomWidget              *w,
  GtkKeynavFailedFunc          *func
);

void gtk_custom_widget_set_query_tooltip_func(
  GtkCustomWidget              *w,
  GtkQueryTooltipFunc          *func
);

void gtk_custom_widget_set_compute_expand_func(
  GtkCustomWidget              *w,
  GtkComputeExpandFunc         *func
);

void gtk_custom_widget_set_css_changed_func(
  GtkCustomWidget              *w,
  GtkCssChangedfunc            *func
);

void gtk_custom_widget_set_system_settings_changed(
  GtkCustomWidget              *w,
  GtkSystemSettingsChangedFunc *func
);
