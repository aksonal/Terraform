#Create a lambda function to calculate the average and percentage of every student and update the Student Record table

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
    Student_Records = table.scan(FilterExpression = Attr('Student_Name').eq('Alfiya Sayyed'))['Items']
    
    #print(Student_Records) this will print a list
    #print (User) this will print dictionary
    
    #now this will print value of key in dictionary
    for user in Student_Records:
        
        Total_Marks = int(user['Science_Marks']) + int(user['Maths_Marks']) + int(user['English_Marks'])
        Percentage = int((Total_Marks/60)*100)
        Average_Marks = Total_Marks//3
        
    print('Total Marks : ',Total_Marks)    
    print('Average Marks : ' ,Average_Marks)
    print('Percentage : ',Percentage)
    
    #Put average marks calculated back to the table
    table.update_item(
    Key={'Student_id': 'S06'},
    UpdateExpression='SET Average = :val1, Percentage = :val2',
                    ExpressionAttributeValues={
                        ':val1': Average_Marks,
                        ':val2': Percentage
                    }
)
    