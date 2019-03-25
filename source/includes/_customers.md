# Customers

## user/status

> &gt;&gt;&gt; Script

```python
[...]
import requests

work_provider_user_id = "12345"

response = requests.get(
    f'https://api.zego.com/v1/user/status/?workProviderUserId={work_provider_user_id}',
    headers={'Authorization': AUTHORIZATION_CODE},
)

print(json.loads(response.content))

```

> &lt;&lt;&lt; Customer / User has a valid product output


```python
{
  "status": "ENABLED",
  "detail": "Valid integrated insurance product found",
  "policyId": "ABC123",  # maintained for backwards compatibility
  "customerNumber": "ABC123",
  "cover_class_of_use": "Carriage of Goods for Hire & Reward",
  "cover_level": "Third Party (TPO)",
  "vehicle_registration": "VY7 JC3"
}
```

> &lt;&lt;&lt; Customer / User does not have a product linked

```python
{
  "status": "DISABLED",
  "detail": "No integrated insurance product linked to <WORK_PROVIDER_NAME>",
  "policyId": "ABC123",  # maintained for backwards compatibility
  "customerNumber": "ABC123",
}
```


Supply a `customerNumber` **OR** `workProviderUserId` and receive status information about that particular Customer/User. If a Customer/User hasn't consented to sharing their information with the requester then the same error message will be received as when the Customer/User is not found.


### Request

Method | URL |
------ | ----|
GET | v1/status/?customerNumber=<A-Z0-9: customerNumber>
GET | v1/status/?workProviderUserId=<str: workProviderUserId>
[Deprecated] GET | v1/status/?policyId=<A-Z0-9: policyId>
[Deprecated] GET | v1/status/?driverId=<str: driverId>


### Response

Status | Response |
------ | ---------|
200 | {"status":"DISABLED", "policyId": <str: policyId>, "customerNumber": <str: customerNumber>, "detail": <str>}
200 | {"status":"ENABLED", "policyId": <str>, "customerNumber": <str>, "cover_class_of_use": <str>, "cover_level": <str>,  "detail": <str>}
200 | {"status":"ENABLED", "policyId": <str>, "customerNumber": <str>, "cover_class_of_use": <str>, "cover_level": <str>,  "detail": <str>, "vehicle_registration": <str>}
400 | {"error":"INVALID_DATA"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
404 | {"error":"INVALID_CUSTOMER"}

<aside class="notice">
  <code>vehicle_registration</code> will only be returned if the Customer/User policy covers a vehicle.
</aside>


## validate/customer-number

> &gt;&gt;&gt; Script

```python

[...]
import requests

customer_number = "ABC12"

response = requests.get(
    'https://api.zego.com/v1/validate/customer-number/{}'.format(customer_number),
    headers={'Authorization': AUTHORIZATION_CODE},
)

print('Response status code: ', response.status_code)

```

> &lt;&lt;&lt; Output


```
Response status code: 204
```


Validate a Zego customer number exists (additionally validate that it matches a given email address).

### Request

Method | URL |
------ | ----|
GET | v1/validate/customer-number/&lt;A-Z0-9: customerNumber&gt;
GET | v1/validate/customer-number/&lt;A-Z0-9: customerNumber&gt;?email=&lt;str: emailAddress&gt;


### Response

Status | Response |
------ | ---------|
204 |
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
404 | {"error":"INVALID_CUSTOMER"}
404 | {"error":"INVALID_CUSTOMER_EMAIL"}

Create and Enrol a customer on a Public Liability product

## customer/enrol/public-liability/

> The request body should contain JSON data in the following format

```json
{
"customer": {
    "address": "25 Luke Street",
    "city": "London",
    "dob": "2000-04-15",
    "email": "raekwon@wutangforever.wu",
    "givenNames": "Reakwon The",
    "lastName": "Chef",
    "phoneNumber": "+4412314323423",
    "postCode": "EC2A 4DS",
    "workProviderUserId": "596e34ee2346c78cc8cf7c4"},
    "product": {
      "occupations": ["childminders"]}
}
```

> &gt;&gt;&gt; Example Request

```python
import requests

response = requests.post(
    'https://api.zego.com/v2/customer/enrol/public-liability/',
    headers={'Authorization': AUTHORIZATION_CODE},
    json={
        'customer': {...},
        'product': {...}
    })
    
print('Response status code:', response.status_code)
print(response.json())

```

> &lt;&lt;&lt; Response

```json
> "Response status code: 200"

{
    "customerNumber": "SE33S",
    "message": "Customer has been enrolled on <PUBLIC_LIABILITY_PRODUCT_NAME",
    "workProviderUserId": "212312qd2131",  # Your internal ID for easier matching
    "status": "ENROLLED",
}
```

Creates a new Customer on the Zego platform and enrols them onto a public liability product. 

<aside class="notice">
In order for a Customer to be successfully created and enrolled on an insurance Product, 
the Product must support API enrolment and the developer account must have permissions 
for API Customer creation. Please contact your Zego Partnerships Manager to enable this feature  
</aside>
 
### Request
 
 
 Method | URL |
------ | ---|
POST   | v2/customer/enrol/public-liability/ | 

 <table>
    <thead>
        <tr>
            <th>Type</th>
            <th colspan="2">Params</th>
            <th>Values</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>HEAD</td>
            <td colspan="2">Authorization</td>
            <td>String</td>
        </tr>
        <tr>
            <td>POST</td>
            <td colspan="2">customer</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>givenNames</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>lastName</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>dob</td>
            <td>String (ISO-8601)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>address</td>
            <td>String (first line only)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>city</td>
            <td>String</td>
        </tr>
         <tr>
            <td></td>
            <td></td>
            <td>postCode</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>email</td>
            <td>String</td>
        </tr>
         <tr>
            <td></td>
            <td></td>
            <td>phoneNumber</td>
            <td>String (including dialing country)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>workProviderUserId</td>
            <td>String</td>
        </tr>
         <tr>
            <td></td>
            <td colspan="2">product</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>occupations</td>
            <td>JSON(List) \["occupation_1", "occupation_2"\] (optional)</td>
        </tr>
    </tbody>
</table>

### Response

Status | Response |
------ | ---------|
202 | ``` { "customerNumber": "SE33S", "workProviderUserId": "212312qd2131", "status": "ENROLLED", "detail": "Customer has been enrolled on <PUBLIC_LIABILITY_PRODUCT>}```
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "detail": "JSON decode error at line 1, column 2" }```

## customer/register/

Creates a user in our system, and registers that user as working for the owner of the API key that made the request.

> The request body should contain JSON data in the following format

```json
{
"customer": {
    "address": "25 Luke Street",
    "city": "London",
    "dob": "2000-04-15",
    "email": "raekwon@wutangforever.wu",
    "givenNames": "Reakwon The",
    "lastName": "Chef",
    "phoneNumber": "+4412314323423",
    "postCode": "EC2A 4DS",
    "workProviderUserId": "596e34ee2346c78cc8cf7c4"},
}
```

### Request
 
 
 Method | URL |
------ | ---|
POST   | /v2/customer/register/ | 

 <table>
    <thead>
        <tr>
            <th>Type</th>
            <th colspan="2">Params</th>
            <th>Values</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>HEAD</td>
            <td colspan="2">Authorization</td>
            <td>String</td>
        </tr>
        <tr>
            <td>POST</td>
            <td colspan="2">customer</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>givenNames</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>lastName</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>dob</td>
            <td>String (ISO-8601)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>address</td>
            <td>String (first line only)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>city</td>
            <td>String</td>
        </tr>
         <tr>
            <td></td>
            <td></td>
            <td>postCode</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>email</td>
            <td>String</td>
        </tr>
         <tr>
            <td></td>
            <td></td>
            <td>phoneNumber</td>
            <td>String (including dialing country)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>workProviderUserId</td>
            <td>String</td>
        </tr>
    </tbody>
</table>

### Response

Status | Response |
------ | ---------|
200 | ``` { "customerNumber": "SE33S", "workProviderUserId": "212312qd2131", "status": "CUSTOMER_CREATED", "message": "Customer has been created"}```
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "detail": "JSON decode error at line 1, column 2" }```

