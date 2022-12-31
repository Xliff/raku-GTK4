
#include <gtk/gtk.h>

typedef SnapshotFunc (void) (GtkSnapshot*, gpointer);

struct _GtkSnapshotBox
{
  GtkBox       parent_instance;
  SnapshotFunc func;
  void         *user_data;
};

typedef struct _GtkSnapshotBox GtkSnapshotBox;

struct _GtkSnapshotBoxClass
{
  GtkBoxClass parent_class;
};
typedef struct _GtkSnapshotBoxClass GtkSnapshotBoxClass;

static GType gtk_snapshot_box_get_type (void);
G_DEFINE_TYPE (GtkSnapshotBox, gtk_custom_snapshot, GTK_TYPE_BOX)


void gtk_custom_snapshot_set_snapshot_func (
  GtkSnapshotBox *box,
  SnapshotFunc    func
) {
  if func {
    box->func = func;
  }
}

static void
custom_snapshot (GtkWidget   *widget,
               GtkSnapshot *snapshot)
{
  GtkSnapshotBox *box = (GtkSnapshotBox *) widget;

  box->func(snapshot, box->user_data);

  GTK_WIDGET_CLASS (gtk_snapshot_box_parent_class)->snapshot (widget, snapshot);

  gtk_snapshot_pop (snapshot);
}


static void
gtk_snapshot_box_init (GtkSnapshotBox *box) {
}

static void
gtk_snapshot_box_class_init (GtkSnapshotBoxClass *klass)
{
  GtkWidgetClass *widget_class = GTK_WIDGET_CLASS (klass);

  widget_class->snapshot = custom_snapshot;
}
