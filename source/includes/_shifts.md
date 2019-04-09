# Shifts

Creates a shift object for a registered Zego Customer. login and logout represent the start and
the end of a given period of time for which the Customer should be insured. 

## shift/login

> The request body should contain JSON data in one of the following formats:

```json
{"workProviderUserId": <WORK_PROVIDER_USER_ID>, "timestamp": <TIMESTAMP>},
```
> OR

```json
{"customerNumber": <CUSTOMER_NUMBER>, "timestamp": <TIMESTAMP>}
```

> &gt;&gt;&gt; Script (using `workProviderUserId`)

```python
[...]
import requests
import datetime
from pytz import UTC

response = requests.post(
    'https://api.zego.com/v1/shift/login/',
    headers={'Authorization': AUTHORIZATION_CODE},
    json={
        'workProviderUserId': '1686',
        'timestamp': UTC.localize(datetime.datetime.utcnow()).isoformat()
    })

print('Response status code:', response.status_code)
print('Response body:', response.text)

```
> &lt;&lt;&lt; Output

```python
Response status code: 202
Response body: {"status": "PENDING"}
```
> Make sure to replace ``'1686'`` with your user's id.


Start an individual Customers's shift for the given CustomerNumber or WorkProviderUserId and timestamp.

<aside class="warning">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided
</aside>

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
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>

### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "detail": "JSON decode error at line 1, column 2" }```


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
import datetime
from pytz import UTC

response = requests.post(
    'https://api.zego.com/v1/shift/logout/',
    headers={'Authorization': AUTHORIZATION_CODE},
    json={
        'customerNumber': '1686',
        'timestamp': UTC.localize(datetime.datetime.utcnow()).isoformat()
    })

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

<aside class="warning">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>

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
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>


### Response

Status | Response |
------ | ---------|
202 | ```{ "status":"PENDING"}```
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "detail": "JSON decode error at line 1, column 2" }```


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
import datetime
from pytz import UTC

now = UTC.localize(datetime.datetime.utcnow())

response = requests.post(
    'https://api.zego.com/v1/batch/login/',
    headers={'Authorization': AUTHORIZATION_CODE},
    json=[
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
<aside class="notice">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>

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
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>

### Response

Status | Response |
------ | ---------|
202 | ```{ "status":"PENDING" }```
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "detail": "JSON decode error at line 1, column 2" }```


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
import datetime
from pytz import UTC

now = UTC.localize(datetime.datetime.utcnow())

response = requests.post(
    'https://api.zego.com/v1/batch/logout/',
    headers={'Authorization': AUTHORIZATION_CODE},
    data=[
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

<aside class="warning">
Only one of <code>customerNumber</code> or <code>workProviderUserId</code> should be provided; see <a href="#introduction">Introduction</a>
</aside>

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
Make sure your server's clock and timezone is appropriately configured in order to produce the timestamps you want.
This should help prevent problems associated with time changes and daylight saving times.
</aside>

### Response

Status | Response |
------ | ---------|
202 | ```{ "status":"PENDING" }```
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "detail": "JSON decode error at line 1, column 2" }```

## /v2/shift/

Creates a shift for the user with a matching customer number or work provider user id.


> The request body should contain JSON data in the following format

```json
{
  "user": {
    "customerNumber": "IT15K",
  },
  "startTime": "2018-12-15T14:00:00+00:00",
  "endTime": null
}
```

### Request
 
 
 Method | URL |
------ | ---|
POST   | /v2/policy/ | 

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
            <td colspan="2">user</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>customerNumber</td>
            <td>String; Not required if `workProviderUserId` is sent.</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>workProviderUserId</td>
            <td>String; Not required if `customerNumber` is sent.</td>
        </tr>
         <tr>
            <td></td>
            <td colspan="2">startTime</td>
            <td>String (ISO-8601 formatted date)</td>
        </tr>
         <tr>
            <td></td>
            <td colspan="2">endTime</td>
            <td>Optional string (ISO-8601 formatted date).</br>Must be `null` if not being set.</td>
        </tr>
    </tbody>
</table>

### Response

Status | Response |
------ | ---------|
201 | ``` { "id": "1", "user": {"customerNumber": "IT15K"}, "startTime": "2018-12-14T14:00:00+00:00", "endTime": null} ```
400 | ```{ "status": "NOK", "error":"INVALID_DATA", "message": "Invalid data format", "detail":  { "startTime ": "`startTime` must be within 30 minutes from now."} }```
401 | ```{ "status": "NOK", "error":"INVALID_KEY", "detail": "Invalid API key" }```
