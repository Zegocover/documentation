# Customer Integration

Methods required to link and match external platform user accounts and Zego customers

## /match

> The request body should contain JSON data in the following formats:

```
{"customerNumber": <CUSTOMER_NUMBER>, "success": <SUCCESS>}

```

<aside class="notice">This end point is expected to be used in the webhook Customer integration flow</aside>


Supply a customer number to confirm that it has been matched to a user and you are ready to start sending shift data, 
or report that no match was possible and additional reconciliation will be required. When `success` is true, 
we will record that the given user has been matched by the authenticated work provider and that they are ready to start sending shifts.


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


<aside class="warning">
This API only accepts a Zego <code>customerNumber</code>.
</aside>

### Response

Status | Response |
------ | ---------|
202 | {"status":"PENDING"}
401 | {"error":"MISSING_AUTH"}
401 | {"error":"INVALID_KEY"}
400 | {"error":"INVALID_DATA"}


## /link-work-provider

> Example

```
v1/link-work-provider?work_provider=Courier%20Ltd&work_provider_user_id=123456&email=driver@example.com
```

> &gt;&gt;&gt; Script

```python
from urllib.parse import urlencode


params = urlencode({
    'work_provider': 'Courier Ltd',
    'work_provider_user_id': '123456',
    'email': 'driver@example.com'
})

driver_url = f'https://api.zego.com/v1/link-work-provider?{params}'

print(driver_url)

```

> Where ``work_provider`` is the name of the work provider (as advised by Zego), ``work_provider_user_id`` is the unique work provider driver id, and ``email`` is the email address of the driver.

> &lt;&lt;&lt; Output


```
https://api.zego.com/v1/link-work-provider?work_provider=Courier+Ltd&work_user_provider_id=123456&email=driver@example.com

```

> Make sure to replace ``'1686'`` with your user's work provider user id.

To allow users of a work providers platform to easily sign up to Zego, or link their existing Zego 
account to a new work provider "``workProviderUserId``", work provider users can be provided with a 
URL that will direct them to the Zego website. This URL can be created by a work provider to provide 
to their users.

New Zego customers will be directed to register and agree terms with their work provider details already 
provided. Existing users will be directed to authenticate and agree work provider terms to link 
their details.

<aside class="notice">Please contact your Zego Partnerships Manager if you wish to use this customer 
integration flow</aside>

### Request

Method | URL |
------ | ----|
GET | v1/link-work-provider


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
            <td colspan="2">work_provider_user_id</td>
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
