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
