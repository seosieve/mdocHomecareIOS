const aws = require("aws-sdk");
const ddb = new aws.DynamoDB();

const tableName = process.env.USERTABLE;

exports.handler = async (event) => {
  // event event.request.userAttributes.sub
  // insert code to be executed by your lambda trigger

  if (!event?.request?.userAttributes?.sub){
    console.log("No sub Provided");
    return;
  }

  const now = new Date();
  const timestamp = now.getTime();

  const userItem = {
    __typename: {S:  'User' },
    _lastChangedAt: { N : timestamp.toString() },
    _version: { N: "1" },
    createdAt: { S: now.toISOString() },
    updatedAt: { S: now.toISOString() },
    id: { S: event.request.userAttributes.sub },
    name: { S: event.request.userAttributes.name },
    email: { S: event.request.userAttributes.email ? event.request.userAttributes.email : "no email" },
    phoneNumber: { S: event.request.userAttributes.phone_number ? event.request.userAttributes.phone_number : "no phone" },
    born:  { S: event.request.userAttributes.nickname },
  }

  const params = {
    Item: userItem,
    TableName: tableName
  }
  

  // save a new user to DynamoDB
  try{
    await ddb.putItem(params).promise();
    console.log("Success");
  }catch(e) {
    console.log(e)
  }

};