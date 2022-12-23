resource "snowflake_procedure" "proc" {
  name     = "WAREHOUSE_DETAILS_V1"
  database = snowflake_database.db["STAGE"].name
  schema   = "PUBLIC"
  language = "JAVASCRIPT"

  comment             = "Procedure compiling existing warehouses in the database"
  return_type         = "VARIANT"
  execute_as          = "CALLER"
  return_behavior     = "IMMUTABLE"
  null_input_behavior = "RETURNS NULL ON NULL INPUT"

  statement = <<EOT
// This variable will hold a JSON data structure that holds ONE row.
var row_as_json = {};
// This array will contain all the rows.
var array_of_rows = [];
// This variable will hold a JSON data structure that we can return as a VARIANT.
// This will contain ALL the rows in a single "value".
var table_as_json = {};

var prop_stmt = snowflake.createStatement({sqlText: "SHOW WAREHOUSES;"});
var rs = prop_stmt.execute();
try {
    while (rs.next()) {
        // Put each row in a variable of type JSON.
        row_as_json = {};
        // For each column in the row...
        row_as_json['name'] = rs.getColumnValue('name');
        row_as_json['warehouse_size'] = rs.getColumnValue('size');
        row_as_json['scaling_policy'] = rs.getColumnValue('scaling_policy');
        row_as_json['min_cluster_count'] = rs.getColumnValue('min_cluster_count');
        row_as_json['max_cluster_count'] = rs.getColumnValue('max_cluster_count');
        row_as_json['auto_suspend'] = rs.getColumnValue('auto_suspend');
        row_as_json['auto_resume'] = (rs.getColumnValue('auto_resume') === 'true');
        row_as_json['comment'] = rs.getColumnValue('comment');
        row_as_json['enable_query_acceleration'] = (rs.getColumnValue('enable_query_acceleration') === 'true');
        row_as_json['query_acceleration_max_scale_factor'] = rs.getColumnValue('query_acceleration_max_scale_factor');
        row_as_json['resource_monitor'] = rs.getColumnValue('resource_monitor');

        var param_stmt = snowflake.createStatement({sqlText: 'SHOW PARAMETERS IN WAREHOUSE ' + rs.getColumnValue('name')});
        var param_rs = param_stmt.execute();
        // iterate over the parameters for timeouts to add them
        while (param_rs.next()) {
            row_as_json[param_rs.getColumnValue('key').toLowerCase()] = Number(param_rs.getColumnValue('value'));
        }
        // Add the row to the array of rows.
        array_of_rows.push(row_as_json);

        return_value = {"warehouses": array_of_rows};
    }
} catch (err) {
    return_value = "Exception in procedure [" + module + "] - ";
    return_value += ", err.code [" + err.code + "], err.state [" + err.state + "]";
    return_value += ", err.message [" + err.message + "]";
    return_value += ", err.stackTraceTxt [" + err.stackTraceTxt + "]";
    return_value += "executing [" + sql + "]";
} finally {
    // Return
    return return_value;
}
EOT
}
