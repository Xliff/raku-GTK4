# use v6.c;
#
# use NativeCall;
#
# use GLib::Raw::Traits;
# use GTK::Raw::Types:ver<4>;
# use GTK::Raw::ComposeTable:ver<4>;
#
# # Boxed
#
# class GTK::ComposeTable:ver<4> {
#   also does GLib::Roles::Implementor;
#
#   has GtkComposeTable $!gtk-ct;
#
#   submethod BUILD ( :gtk-compose-table(:$!gtk-ct) ) { }
#
#   method GTK::Raw::Structs::GtkComposeTable
#   { $!gtk-ct }
#
#   method new_with_data (
#     CArray[guint16] $data,
#     Int()           $max_seq_len,
#     Int()           $n_seqs
#   ) {
#     my gint16 ($m, $n) = ($max_seq_len, $n_seqs);
#
#     my $gtk-compose-table = gtk_compose_table_new_with_data($data, $m, $n);
#
#     $gtk-compose-table ?? self.bless( :$gtk-compose-table ) !! Nil;
#   }
#
#   method new_with_file (Str() $compose_file) {
#     my $gtk-compose-table = gtk_compose_table_new_with_file($compose_file);
#
#     $gtk-compose-table ?? self.bless( :$gtk-compose-table ) !! Nil;
#   }
#
#   method parse (Str() $compose_file, Int() $found_include) {
#     my gboolean $f = $found_include.so.Int;
#
#     my $gtk-compose-table = gtk_compose_table_parse($compose_file, $f);
#
#     $gtk-compose-table ?? self.bless( :$gtk-compose-table ) !! Nil;
#   }
#
#   method check (
#     guint           $compose_buffer is rw,
#     gint            $n_compose,
#     gboolean        $compose_finish,
#     gboolean        $compose_match,
#     GString         $output
#   ) {
#     gtk_compose_table_check(
#       $!gtk-ct,
#       $compose_buffer,
#       $n_compose,
#       $compose_finish,
#       $compose_match,
#       $output
#     );
#   }
#
#   method data_hash (
#     guint16 $data is rw,
#     gint    $max_seq_len,
#     gint    $n_seqs
#   )
#     is static
#   {
#     gtk_compose_table_data_hash($max_seq_len, $n_seqs);
#   }
#
#   method foreach (&callback, gpointer $data = gpointer) {
#     gtk_compose_table_foreach($!gtk-ct, &callback, $data);
#   }
#
#   method get_prefix (
#     guint           $compose_buffer is rw,
#     gint            $n_compose,
#     gint            $prefix is rw
#   ) {
#     gtk_compose_table_get_prefix(
#       $!gtk-ct,
#       $compose_buffer,
#       $n_compose,
#       $prefix
#     );
#   }
#
#   method get_x11_compose_file_dir is static {
#     gtk_compose_table_get_x11_compose_file_dir();
#   }
#
#   method gtk_check_algorithmically (
#     gint    $n_compose,
#     GString $output
#   ) {
#     gtk_check_algorithmically($!gtk-ct, $n_compose, $output);
#   }
#
# }
