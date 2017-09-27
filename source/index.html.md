---
title: Zego API Specification

language_tabs: # must be one of https://git.io/vQNgJ
  - python

toc_footers:
  - <a href='https://www.zegocover.com'>www.zegocover.com</a>

includes:
  - versions

search: true
---

# Introduction

The methods below all require identification of a particular Zego customer.

This can be done in one of two ways:

- ``policyId`` (also referred to as “customer number”) is a unique identifier that Zego assigns to each of its customers.

- ``driverId`` is an identifier assigned by the work provider to uniquely identify its drivers.

    Zego can obtain this identifier during customer signup, and use it to identify that customer during communication with the applicable work provider.

For the API calls below, either the ``policyId`` or the ``driverId`` parameter can be sent.

# Methods
## shift/login

> The request body should contain JSON data in one of the following formats:

```
{"driverId": <DRIVER_ID>, "timestamp": <TIMESTAMP>},

OR

{"policyId": <POLICY_ID>, "timestamp": <TIMESTAMP>}
```

> &gt;&gt;&gt; Script (using `driverId`)

```python
[...]
import requests

response = requests.post(
    'https://api.zegocover.com/v1/shift/login/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps({
        'driverId': '1686',
        'timestamp': datetime.datetime.now().isoformat()
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
            <td>policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601)</td>
        </tr>
    </tbody>
</table>

<aside class="notice">
Only one of <code>policyId</code> or <code>driverId</code> should be provided; see <a href="#introduction">Introduction</a>
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
{"driverId": <DRIVER_ID>, "timestamp": <TIMESTAMP>}

OR

{"policyId": <POLICY_ID>, "timestamp": <TIMESTAMP>}
```

> &gt;&gt;&gt; Script (using `driverId`)

```python
[...]
import requests


response = requests.post(
    'https://api.zegocover.com/v1/shift/logout/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps({
        'driverId': '1686',
        'timestamp': datetime.datetime.now().isoformat()
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
> Make sure to replace ``'1686'`` with your driver's id.


Logs the given driver out at the given timestamp.


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
            <td>policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601)</td>
        </tr>
    </tbody>
</table>

<aside class="notice">
Only one of <code>policyId</code> or <code>driverId</code> should be provided; see <a href="#introduction">Introduction</a>
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
    {"driverId": <DRIVER_ID>, "timestamp": <TIMESTAMP>},
    {"driverId": <DRIVER_ID>, "timestamp": <TIMESTAMP>},
    ...
]

OR

[
    {"policyId": <POLICY_ID>, "timestamp": <TIMESTAMP>},
    {"policyId": <POLICY_ID>, "timestamp": <TIMESTAMP>},
    ...
]
```

> &gt;&gt;&gt; Script (using `driverId`)

```python
[...]
import requests

now = datetime.datetime.now()

response = requests.post(
    'https://api.zegocover.com/v1/batch/login/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps([
        {
            'driverId': '1686',
            'timestamp': now.isoformat()
        },
        {
            'driverId': '8545',
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

> Make sure to replace ``'1686'`` and ``'8545'`` with your drivers' id.


Supply a list of policyIds or driverIds and timestamps to start shifts for multiple users with one request.


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
            <td>policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601)</td>
        </tr>
    </tbody>
</table>


<aside class="notice">
Only one of <code>policyId</code> or <code>driverId</code> should be provided; see <a href="#introduction">Introduction</a>
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
    {"driverId": <DRIVER_ID>, "timestamp": <TIMESTAMP>},
    {"driverId": <DRIVER_ID>, "timestamp": <TIMESTAMP>},
    ...
]

OR

[
    {"policyId": <POLICY_ID>, "timestamp": <TIMESTAMP>},
    {"policyId": <POLICY_ID>, "timestamp": <TIMESTAMP>},
    ...
]
```

> &gt;&gt;&gt; Script (using `driverId`)

```python
[...]

now = datetime.datetime.now()

response = requests.post(
    'https://api.zegocover.com/v1/batch/logout/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=json.dumps([
        {
            'driverId': '1686',
            'timestamp': now.isoformat()
        },
        {
            'driverId': '8545',
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

> Make sure to replace ``'1686'`` and ``'8545'`` with your drivers' id.

Supply a list of policyIds or driverIds and timestamps to start shifts for multiple users with one request.


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
            <td>policyId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>driverId</td>
            <td>String (optional)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>timestamp</td>
            <td>String (ISO-8601)</td>
        </tr>
    </tbody>
</table>


<aside class="notice">
Only one of <code>policyId</code> or <code>driverId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>

### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
400 | {"error":"INVALID_DATA"}


## validate/customer-number

> &gt;&gt;&gt; Script

```python

[...]
import requests

customer_number = "ABC12"

response = requests.get(
    'https://api.zegocover.com/v1/validate/customer-number/{}'.format(customer_number),
    headers={'Authorization': AUTHORIZATION_CODE},
)

print('Response status code: ', response.status_code)

```

> &lt;&lt;&lt; Output


```
Response status code: 204
```


Validate a Zego policy ID exists (additionally validate that it matches a given email address).

### Request

Method | URL |
------ | ----|
GET | v1/validate/customer-number/&lt;A-Z0-9: policyId&gt;
GET | v1/validate/customer-number/&lt;A-Z0-9: policyId&gt;?email=&lt;str: emailAddress&gt;


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
/link-work-provider?wp=Courier%20Ltd&wp_id=123456&email=driver@example.com
```

> &gt;&gt;&gt; Script

```python
from urllib.parse import urlencode


params = urlencode({
    'wp': 'Courier Ltd',
    'wp_id': '123456',
    'email': 'driver@example.com'
})

driver_url = f'https://api.zegocover.com/link-work-provider?{params}'

print(driver_url)

```

> Where ``wp`` is the name of the work provider (as advised by Zego), ``wp_id`` is the unique work provider driver id, and ``email`` is the email address of the driver.

> &lt;&lt;&lt; Output


```
https://api.zegocover.com/link-work-provider?wp=Courier+Ltd&wp_id=123456&email=driver@example.com

```

> Make sure to replace ``'1686'`` with your driver's id.


To allow their drivers to to easily sign up to Zego, or link their existing Zego account to a new work provider ``driverId``, drivers can be provided with a URL that will direct them to the Zego website. This URL can be created by a work provider to provide to their drivers.

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
            <td colspan="2">wp</td>
            <td>String</td>
        </tr>
        <tr>
            <td></td>
            <td colspan="2">wp_id</td>
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
