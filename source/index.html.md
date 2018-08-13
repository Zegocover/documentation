---
title: Zego API Specification

language_tabs: # must be one of https://git.io/vQNgJ
  - python

toc_footers:
  - <a href='https://www.zego.com'>www.zego.com</a>

includes:
  - versions

search: true
---

# Introduction

The methods below all require identification of a particular Zego customer.

This can be done in one of two ways:

- ``customerNumber`` is a unique identifier that Zego assigns to each of its customers.

- ``workProviderUserId`` is an identifier assigned by the work provider to uniquely identify its drivers.

    Zego can obtain this identifier during customer signup, and use it to identify that customer during communication with the applicable work provider.

For the API calls below, either the ``customerNumber`` or the ``workProviderUserId`` parameter can be sent.
    
<aside class="notice">
Previous version of this API used the <code>policyId</code> and <code>driverId</code> fields instead of <code>customerNumber</code> and <code>workProviderUserId</code> respectively.
Although these fields are still supported by the api, they have been deprecated and should no longer be used in new integrations.
</aside>

# Methods
## shift/login

> The request body should contain JSON data in one of the following formats:

```
{"workProviderUserId": <WORK_PROVIDER_USER_ID>, "timestamp": <TIMESTAMP>},

OR

{"customerNumber": <CUSTOMER_NUMBER>, "timestamp": <TIMESTAMP>}
```

> &gt;&gt;&gt; Script (using `workProviderUserId`)

```python
[...]
import requests
from pytz import UTC

response = requests.post(
    'https://api.zego.com/v1/shift/login/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps({
        'workProviderUserId': '1686',
        'timestamp': UTC.localize(datetime.datetime.utcnow()).isoformat()
    })
)
print('Response status code:', response.status_code)
print('Response body:', response.text)

```
> &lt;&lt;&lt; Output

```python
Response status code: 202
Response body: {"status": "PENDING"}
```
> Make sure to replace ``'1686'`` with your driver's id.


Start an individual user's shift for the given driver and timestamp.

### Request

Method | URL |
------ | ----|
POST | v1/shift/login/


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
            <td colspan="2">body</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>customerNumber</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>workProviderUserId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601 with timezone)</td>
        </tr>
    </tbody>
</table>

<aside class="notice">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>
<aside class="notice">
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>

### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
400 | {"error":"INVALID_DATA"}

## shift/logout

> The request body should contain JSON data in one of the following formats:

```
{"workProviderUserId": <WORK_PROVIDER_USER_ID>, "timestamp": <TIMESTAMP>}

OR

{"customerNumber": <CUSTOMER_NUMBER>, "timestamp": <TIMESTAMP>}
```

> &gt;&gt;&gt; Script (using `customerNumber`)

```python
[...]
import requests
from pytz import UTC

response = requests.post(
    'https://api.zego.com/v1/shift/logout/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps({
        'customerNumber': '1686',
        'timestamp': UTC.localize(datetime.datetime.utcnow()).isoformat()
    })
)
print('Response status code:', response.status_code)
print('Response body:', response.text)

```
> &lt;&lt;&lt; Output

```
Response status code: 202
Response body: {"status": "PENDING"}
```
> Make sure to replace ``'1686'`` with your user's work provider user id.


Logs the given user out at the given timestamp.


### Request

Method | URL |
------ | ----|
POST | v1/shift/logout/


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
            <td colspan="2">body</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>customerNumber</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>workProviderUserId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601 with timezone)</td>
        </tr>
    </tbody>
</table>

<aside class="notice">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>
<aside class="notice">
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>


### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
400 | {"error":"INVALID_DATA"}


## batch/login

> The request body should contain JSON data in the following formats:

```
[
    {"workProviderUserId": <WORK_PROVIDER_USER_ID>, "timestamp": <TIMESTAMP>},
    {"workProviderUserId": <WORK_PROVIDER_USER_ID>, "timestamp": <TIMESTAMP>},
    ...
]

OR

[
    {"customerNumber": <CUSTOMER_NUMBER>, "timestamp": <TIMESTAMP>},
    {"customerNumber": <CUSTOMER_NUMBER>, "timestamp": <TIMESTAMP>},
    ...
]
```

> &gt;&gt;&gt; Script (using `customerNumber`)

```python
[...]
import requests
from pytz import UTC

now = UTC.localize(datetime.datetime.utcnow())

response = requests.post(
    'https://api.zego.com/v1/batch/login/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps([
        {
            'customerNumber': '1686',
            'timestamp': now.isoformat()
        },
        {
            'customerNumber': '8545',
            'timestamp': now.isoformat()
        },
        # [...]
    ])
)
print('Response status code:', response.status_code)
print('Response body:', response.text)

```

> &lt;&lt;&lt; Output


```
Response status code: 202
Response body: {"status": "PENDING"}
```

> Make sure to replace ``'1686'`` and ``'8545'`` with your user's work provider user id.


Supply a list of customerIds or workProviderUserIds and timestamps to start shifts for multiple users with one request.


### Request

Method | URL |
------ | ----|
POST | v1/batch/login/


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
            <td colspan="2">body</td>
            <td>JSON (Array:[Object])</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>customerNumber</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>workProviderUserId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601 with timezone)</td>
        </tr>
    </tbody>
</table>


<aside class="notice">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>
<aside class="notice">
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>

### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
400 | {"error":"INVALID_DATA"}


## batch/logout

> The request body should contain JSON data in the following formats:

```
[
    {"workProviderUserId": <WORK_PROVIDER_USER_ID>, "timestamp": <TIMESTAMP>},
    {"workProviderUserId": <WORK_PROVIDER_USER_ID>, "timestamp": <TIMESTAMP>},
    ...
]

OR

[
    {"customerNumber": <CUSTOMER_NUMBER>, "timestamp": <TIMESTAMP>},
    {"customerNumber": <CUSTOMER_NUMBER>, "timestamp": <TIMESTAMP>},
    ...
]
```

> &gt;&gt;&gt; Script (using `workProviderUserId`)

```python
[...]
import requests
from pytz import UTC

now = UTC.localize(datetime.datetime.utcnow())

response = requests.post(
    'https://api.zego.com/v1/batch/logout/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps([
        {
            'workProviderUserId': '1686',
            'timestamp': now.isoformat()
        },
        {
            'workProviderUserId': '8545',
            'timestamp': now.isoformat()
        },
        # [...]
    ])
)
print('Response status code:', response.status_code)
print('Response body:', response.text)

```
> &lt;&lt;&lt; Output

```
Response status code: 202
Response body: {"status": "PENDING"}
```

> Make sure to replace ``'1686'`` and ``'8545'`` with your user's work provider user id.

Supply a list of customerNumbers or workProviderUserIds and timestamps to start shifts for multiple users with one request.


### Request

Method | URL |
------ | ----|
POST | v1/batch/logout/


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
            <td colspan="2">body</td>
            <td>JSON (Array:[Object])</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>customerNumber</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>workProviderUserId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601 with timezone).</td>
        </tr>
    </tbody>
</table>


<aside class="notice">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>
<aside class="notice">
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>

### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
400 | {"error":"INVALID_DATA"}


## match

> The request body should contain JSON data in the following formats:

```
{"customerNumber": <CUSTOMER_NUMBER>, "success": <SUCCESS>}

```

Supply a customer number to confirm that it has been matched to a user and you are ready to start sending shift data, or report that no match was possible and additional reconciliation will be required.

When `success` is true, we will record that the given user has been matched by the authenticated work provider and that they are ready to start sending shifts.


### Request

Method | URL |
------ | ----|
POST | v1/match/


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
            <td colspan="2">body</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>customerNumber</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>[Deprecated] policyId</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>success</td>
            <td>Boolean</td>
        </tr>
    </tbody>
</table>


<aside class="notice">
This API only accepts a Zego <code>customerNumber</code>.
</aside>

### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
400 | {"error":"INVALID_DATA"}



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

Supply a customer number or work provider user id and receive status information about that particular driver. If a user hasn't consented to sharing their information with the requester then the same error message will be received as when the driver is not found.


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


## link-work-provider


> Example

```
/link-work-provider?work_provider=Courier%20Ltd&work_provider_id=123456&email=driver@example.com
```

> &gt;&gt;&gt; Script

```python
from urllib.parse import urlencode


params = urlencode({
    'work_provider': 'Courier Ltd',
    'work_provider_user_id': '123456',
    'email': 'driver@example.com'
})

driver_url = f'https://api.zego.com/link-work-provider?{params}'

print(driver_url)

```

> Where ``work_provider`` is the name of the work provider (as advised by Zego), ``work_provider_id`` is the unique work provider driver id, and ``email`` is the email address of the driver.

> &lt;&lt;&lt; Output


```
https://api.zego.com/link-work-provider?work_provider=Courier+Ltd&work_provider_id=123456&email=driver@example.com

```

> Make sure to replace ``'1686'`` with your user's work provider user id.


To allow their drivers to to easily sign up to Zego, or link their existing Zego account to a new work provider ``workProviderUserId``, drivers can be provided with a URL that will direct them to the Zego website. This URL can be created by a work provider to provide to their drivers.

New Zego users will be directed to register and agree terms with their work provider details already provided. Existing users will be directed to authenticate and agree work provider terms to link their details.

### Request

Method | URL |
------ | ----|
GET | link-work-provider


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
            <td>GET</td>
            <td colspan="2">work_provider</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">work_provider_id</td>
            <td>String</td>
        </tr>
        <tr>
            <td>GET</td>
            <td colspan="2">[Deprecated] wp</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">[Deprecated] wp_id</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">email</td>
            <td>String</td>
        </tr>
    </tbody>
</table>

### Response

Status | Response |
------ | ---------|
302 |


The site will redirect the user to the correct next step (linking, login, or sign up) depending on their account and session status.
