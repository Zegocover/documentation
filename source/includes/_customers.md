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

> &lt;&lt;&lt; Output


```python
{
  "status": "ENABLED",
  "policyId": "ABC123",  # maintained for backwards compatibility
  "customer_number": "ABC123",
  "cover_class_of_use": "Carriage of Goods for Hire & Reward",
  "cover_level": "Third Party (TPO)",
  "vehicle_registration": "VY7 JC3"
}
```

Supply a customer number or work provider user id and receive status information about that particular user. If a user hasn't consented to sharing their information with the requester then the same error message will be received as when the user is not found.


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
200 | {"status":"DISABLED", "policyId": <str: policyId>, "customer_number": <str: customer_number>}
200 | {"status":"ENABLED", "policyId": <str>, "customer_number": <str>, cover_class_of_use": <str>, "cover_level": <str>}
200 | {"status":"ENABLED", "policyId": <str>, "customer_number": <str>, cover_class_of_use": <str>, "cover_level": <str>, "vehicle_registration": <str>}
400 | {"error":"INVALID_DATA"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
404 | {"error":"INVALID_CUSTOMER"}

<aside class="notice">
  <code>vehicle_registration</code> will only be returned if the users policy is specific to a vehicle.
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

Create customers on the Zego platform and perform actions on those Customers

## customer/enrol

> The request body should contain JSON data in the following format

```json
{
    "customer": {
        "givenNames": "Reakwon The",
        "lastName": "Chef",
        "address": "25 Luke Street",
        "city": "London",
        "postCode": "EC2A 4DS",
        "dob": "1984-01-15",
        "email": "raekwon@wutangforever.wu",
        "phoneNumber": "+44012314323423",
        "workProviderUserId": "596e34ee2346c78cc8cf7c4"},
    "product": {
        "code": "FL.OCC.PL.UK.001",
        "occupations": ["babysitter"]}
}
```

> &gt;&gt;&gt; Example Request

```python
import requests

response = requests.post(
    'https://api.zego.com/v1/customer/enrol/',
    headers={'Authorization': AUTHORIZATION_CODE},
    json={
        'customer': {...},
        'product': {...}
    })
    
print('Response status code:', response.status_code)
print(response.json())

```

> &lt;&lt;&lt; Response

```python
> "Response status code: 200"

> {
    'customerNumber': 'SE33S',
    'occupations': ['childminder'],
    'workProviderUserId': '212312qd2131',  # Your internal ID for easier matching
    'status': 'Created',
    'coverLevel': 'Public Liability'
}
```

Creates a new Customer on the Zego platform and enrols them onto a product. 

<aside class="notice">
In order for a Customer to be successfully created and enrolled on an insurance Product, 
the Product must support API enrolment and the developer account must have permissions 
for API Customer creation. Please contact your Zego Partnerships Manager to enable this feature  
</aside>
 
 
 ### Request
 
 
 Method | URL |
------ | ---|
POST   | v1/customer/enrol | 

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
            <td>code</td>
            <td>String</td>
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
202 | ``` { "customerNumber": "SE33S", "occupations": ["childminder"],"workProviderUserId": "212312qd2131", "status": "Created", "coverLevel": "Public Liability" }```
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "detail": "JSON decode error at line 1, column 2" }```
