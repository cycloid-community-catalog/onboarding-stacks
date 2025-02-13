resource "aws_db_parameter_group" "rds-optimized" {
  name        = "${var.cyorg}-${var.cyproject}-${var.cyenv}-${var.cycomp}"
  family      = "mysql8.0"
  description = "Cycloid optimizations"

  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }

  parameter {
    name         = "query_cache_type"
    value        = "1"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "innodb_buffer_pool_size"
    value        = "{DBInstanceClassMemory*2/3}"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_allowed_packet"
    value        = "67108864"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "query_cache_size"
    value        = "0"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "tmp_table_size"
    value        = "134217728"
    apply_method = "pending-reboot"
  }

  parameter {
    name         = "max_heap_table_size"
    value        = "134217728"
    apply_method = "pending-reboot"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    name  = "log_output"
    value = "file"
  }
}