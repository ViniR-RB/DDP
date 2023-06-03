abstract class SqlDatabase {
  static String userSql =
      'CREATE TABLE IF NOT EXISTS users (id UUID PRIMARY KEY,name VARCHAR(255),email TEXT UNIQUE,password VARCHAR(255))';
  static String contactSql =
      'CREATE TABLE IF NOT EXISTS contacts (id UUID PRIMARY KEY,name VARCHAR(255), addres varchar(255) ,user_id UUID,phone VARCHAR(11), latitude DECIMAL(9,6),longitude DECIMAL(9,6),FOREIGN KEY (user_id) REFERENCES users (id))';
}
