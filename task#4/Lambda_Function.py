#Lambda Code

#AWS SDK for python
import boto3

#to use attribute to sort query import this packages from boto3
from boto3.dynamodb.conditions import Key,Attr

def lambda_handler(event, context):
    
    #connect to DynamoDB
    client = boto3.resource("dynamodb")
    
    #variable to store table, here 'Student_Record' is the table name
    table = client.Table("Student_Record")
    
    #Pull all info from the table using scan() function
    Student_Records = table.scan(FilterExpression = Attr('Student_Name').eq('Ayesha Ahmed'))['Items']
    
    #print(Student_Records) this will print a list
    #print (User) this will print dictionary
    
    #now this will print value of key in dictionary
    for user in Student_Records:
        
        Total_Marks = user['Science_Marks'] + user['Maths_Marks'] + user['English_Marks']
        Percentage = int((Total_Marks/60)*100)
        Average_Marks = Total_Marks//3
        
    print('Total Marks : ',Total_Marks)    
    print('Average Marks : ' ,Average_Marks)
    print('Percentage : ',Percentage)
    
    #Put average marks calculated back to the table
    response = table.put_item(
    Item={
        
        'Student_id': 'S01', 
        'English_Marks' : '20',
        'Maths_Marks': '15',
        'Science_Marks': '18',
        'Student_Name' : 'Ayesha Ahmed',
        'Average': Average_Marks,
        'Percentage': Percentage
    }
)