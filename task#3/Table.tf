#Find the Description of the New Assignment Below, All tasks need to be performed using terraform.

#1)Create A table in DynamoDB.
#Table Name- “Student Record”
#Items- Student Name, English Marks, Math’s Marks, Science Marks .

#Add items in table in DynamoDB
resource "aws_dynamodb_table_item" "Student_Record" {
  table_name = "${aws_dynamodb_table.Student_Record.name}"
  hash_key   = "${aws_dynamodb_table.Student_Record.hash_key}"

  item = <<ITEM
{
  "Student_id": {"S": "S01"},
  "Student_Name": {"S": "Ayesha Ahmed"},
  "English_Marks": {"N": "20"},
  "Maths_Marks": {"N": "15"},
  "Science_Marks": {"N": "18"}
  
}
ITEM
}

#create table in DynamoDB
resource "aws_dynamodb_table" "Student_Record" {
  name           = "Student_Record"
  read_capacity  = 3
  write_capacity = 3
  hash_key       = "Student_id"

  attribute {
    name = "Student_id"
    type = "S"
  }
}