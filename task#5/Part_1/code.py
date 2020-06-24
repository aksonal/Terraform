#Code for part 1 of task
#CODE:
#lambda function which allows API which invokes this function to read the table.

import boto3
from boto3.dynamodb.conditions import Key,Attr

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Student_Record')

def lambda_handler(event, context):
    # TODO implement
  
    Student_Records = table.scan()['Items']
   
    return Student_Records