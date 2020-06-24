#Code for part 2 of task
#CODE:
#lambda function which allows API which invokes this function to insert data into the table.

import boto3


dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Student_Record')

def lambda_handler(event, context):
    
    # TODO implement
    response = table.put_item(
    Item={
        
        'Student_id': 'S03', 
        'English_Marks' : '10',
        'Maths_Marks': '5',
        'Science_Marks': '12',
        'Student_Name' : 'Kunal Nayar',
        'Average': "44",
        'Percentage': '60'
    }
)
    
   
    #return Student_Records
