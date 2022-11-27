

### /usr/src/gtk4-4.8.1+ds/gtk/gtkscrollbar.h

sub gtk_scrollbar_get_adjustment (GtkScrollbar $self) 
  returns GtkAdjustment
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollbar_get_type  
  returns GType
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollbar_new (
  GtkOrientation $orientation,
  GtkAdjustment  $adjustment
) 
  returns GtkWidget
  is      native(gtk4)
  is      export
{ * }

sub gtk_scrollbar_set_adjustment (
  GtkScrollbar  $self,
  GtkAdjustment $adjustment
) 
  is      native(gtk4)
  is      export
{ * }

