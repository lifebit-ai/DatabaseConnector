#' @param dbms               The type of DBMS running on the server. Valid values are
#'                           \itemize{
#'                             \item {"oracle" for Oracle}
#'                             \item {"postgresql" for PostgreSQL}
#'                             \item {"redshift" for Amazon Redshift}
#'                             \item {"sql server" for Microsoft SQL Server}
#'                             \item {"pdw" for Microsoft Parallel Data Warehouse (PDW)}
#'                             \item {"netezza" for IBM Netezza}
#'                             \item {"bigquery" for Google BigQuery}
#'                             \item {"sqlite" for SQLite}
#'                             \item {"sqlite extended" for SQLite with extended types (DATE and
#'                                   DATETIME)}
#'                             \item {"spark" for Spark}
#'                           }
#'
#'
#' @param user               The user name used to access the server.
#' @param password           The password for that user.
#' @param server             The name of the server.
#' @param port               (optional) The port on the server to connect to.
#' @param extraSettings      (optional) Additional configuration settings specific to the database
#'                           provider to configure things as security for SSL. These must follow the
#'                           format for the JDBC connection for the RDBMS specified in dbms.
#' @param oracleDriver       Specify which Oracle drive you want to use. Choose between \code{"thin"}
#'                           or \code{"oci"}.
#' @param connectionString   The JDBC connection string. If specified, the \code{server}, \code{port},
#'                           \code{extraSettings}, and \code{oracleDriver} fields are ignored. If
#'                           \code{user} and \code{password} are not specified, they are assumed to
#'                           already be included in the connection string.
#' @param pathToDriver       Path to a folder containing the JDBC driver JAR files. See
#'                           \code{\link{downloadJdbcDrivers}} for instructions on how to download the
#'                           relevant drivers.
#'
#' @section DBMS parameter details: 
#' 
#' Depending on the DBMS, the function arguments have slightly different
#' interpretations: Oracle:
#' \itemize{
#'   \item \code{user}. The user name used to access the server
#'   \item \code{password}. The password for that user
#'   \item \code{server}. This field contains the SID, or host and servicename, SID, or TNSName:
#'         '<sid>', '<host>/<sid>', '<host>/<service name>', or '<tnsname>'
#'   \item \code{port}. Specifies the port on the server (default = 1521)
#'   \item \code{extraSettings} The configuration settings for the connection (i.e. SSL Settings such
#'         as "(PROTOCOL=tcps)")
#'   \item \code{oracleDriver} The driver to be used. Choose between "thin" or "oci".
#'   \item \code{pathToDriver} The path to the folder containing the Oracle JDBC driver JAR files.
#' }
#' Microsoft SQL Server:
#' \itemize{
#'   \item \code{user}. The user used to log in to the server. If the user is not specified, Windows
#'         Integrated Security will be used, which requires the SQL Server JDBC drivers to be installed
#'         (see details below).
#'   \item \code{password}. The password used to log on to the server
#'   \item \code{server}. This field contains the host name of the server
#'   \item \code{port}. Not used for SQL Server
#'   \item \code{extraSettings} The configuration settings for the connection (i.e. SSL Settings such
#'         as "encrypt=true; trustServerCertificate=false;")
#'   \item \code{pathToDriver} The path to the folder containing the SQL Server JDBC driver JAR files.
#' }
#' Microsoft PDW:
#' \itemize{
#'   \item \code{user}. The user used to log in to the server. If the user is not specified, Windows
#'         Integrated Security will be used, which requires the SQL Server JDBC drivers to be installed
#'         (see details below).
#'   \item \code{password}. The password used to log on to the server
#'   \item \code{server}. This field contains the host name of the server
#'   \item \code{port}. Not used for SQL Server
#'   \item \code{extraSettings} The configuration settings for the connection (i.e. SSL Settings such
#'         as "encrypt=true; trustServerCertificate=false;")
#'   \item \code{pathToDriver} The path to the folder containing the SQL Server JDBC driver JAR files.
#' }
#' PostgreSQL:
#' \itemize{
#'   \item \code{user}. The user used to log in to the server
#'   \item \code{password}. The password used to log on to the server
#'   \item \code{server}. This field contains the host name of the server and the database holding the
#'         relevant schemas: <host>/<database>
#'   \item \code{port}. Specifies the port on the server (default = 5432)
#'   \item \code{extraSettings} The configuration settings for the connection (i.e. SSL Settings such
#'         as "ssl=true")
#'   \item \code{pathToDriver} The path to the folder containing the PostgreSQL JDBC driver JAR files.
#' }
#' Redshift:
#' \itemize{
#'   \item \code{user}. The user used to log in to the server
#'   \item \code{password}. The password used to log on to the server
#'   \item \code{server}. This field contains the host name of the server and the database holding the
#'         relevant schemas: <host>/<database>
#'   \item \code{port}. Specifies the port on the server (default = 5439)
#'   \item \code{extraSettings} The configuration settings for the connection (i.e. SSL Settings such
#'         as "ssl=true&sslfactory=com.amazon.redshift.ssl.NonValidatingFactory")
#'   \item \code{pathToDriver} The path to the folder containing the RedShift JDBC driver JAR files.
#' }
#' Netezza:
#' \itemize{
#'   \item \code{user}. The user used to log in to the server
#'   \item \code{password}. The password used to log on to the server
#'   \item \code{server}. This field contains the host name of the server and the database holding the
#'         relevant schemas: <host>/<database>
#'   \item \code{port}. Specifies the port on the server (default = 5480)
#'   \item \code{extraSettings} The configuration settings for the connection (i.e. SSL Settings such
#'         as "ssl=true")
#'   \item \code{pathToDriver} The path to the folder containing the Netezza JDBC driver JAR file
#'         (nzjdbc.jar).
#' }
#' Impala:
#' \itemize{
#'   \item \code{user}. The user name used to access the server
#'   \item \code{password}. The password for that user
#'   \item \code{server}. The host name of the server
#'   \item \code{port}. Specifies the port on the server (default = 21050)
#'   \item \code{extraSettings} The configuration settings for the connection (i.e. SSL Settings such
#'         as "SSLKeyStorePwd=*****")
#'   \item \code{pathToDriver} The path to the folder containing the Impala JDBC driver JAR files.
#' }
#' SQLite:
#' \itemize{
#'   \item \code{server}. The path to the SQLIte file.
#' }
#' Spark:
#' \itemize{
#'   \item \code{connectionString}. The connection string (e.g. starting with
#'         'jdbc:spark://my-org.dev.cloud.databricks.com...').
#'   \item \code{user}. The user name used to access the server.
#'   \item \code{password}. The password for that user.
#' }
#'
#' @section Windows authentication for SQL Server:
#' 
#' To be able to use Windows authentication for SQL Server (and PDW), you have to install the JDBC
#' driver. Download the version 9.2.0 .zip from \href{https://docs.microsoft.com/en-us/sql/connect/jdbc/release-notes-for-the-jdbc-driver?view=sql-server-ver15#92-releases}{Microsoft} 
#' and extract its contents to a folder. In the extracted folder you will find the file
#' sqljdbc_9.2/enu/auth/x64/mssql-jdbc_auth-9.2.0.x64.dll (64-bits) or
#' ssqljdbc_9.2/enu/auth/x86/mssql-jdbc_auth-9.2.0.x86.dll (32-bits), which needs to be moved to
#' location on the system path, for example to c:/windows/system32. If you not have write access to
#' any folder in the system path, you can also specify the path to the folder containing the dll by
#' setting the environmental variable PATH_TO_AUTH_DLL, so for example
#' \code{Sys.setenv("PATH_TO_AUTH_DLL" = "c:/temp")} Note that the environmental variable needs to be
#' set before calling \code{connect} for the first time.
