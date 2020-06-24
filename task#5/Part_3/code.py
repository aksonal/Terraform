#Code for part 3 of task
#CODE:
#lambda function which allows API which invokes this function to query the data acc to input from the table.

import boto3
from boto3.dynamodb.conditions import Key,Attr

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Student_Record')

def lambda_handler(event, context):
    # TODO implement
    percent = event['percent']
    Student_Records = table.scan(FilterExpression = Attr('Percentage').eq(percent))['Items']
    
    return Student_Records
    