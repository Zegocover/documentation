# Policies

## /v2/policy/

Note: this endpoint is currently in beta. The format of the request and the response may change without notice.

Creates a one-day fixed term Public Liability policy for the subject, the premium of which will be paid for by the work
provider creating the policy. This policy can be created for the user and can cover one or several occupations.


> The request body should contain JSON data in the following format

```json
{
  "subject": {
    "customerNumber": "IT15K"
  },
  "policyOptions": {
    "occupations": ["accountants_or_bookkeepers"],
    "coverAmount": "pl_1000000",
    "startDate": "2018-12-15T14:00:00+00:00"
  }
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
            <td colspan="2">subject</td>
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
            <td colspan="2">policyOptions</td>
            <td>JSON (Object)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>occupations</td>
            <td>JSON (List) (eg. `["occupation_1", "occupation_2"]`)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>coverAmount</td>
            <td>String (eg. `pl_1000000` for 1 million pounds of cover)</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td>startDate</td>
            <td>String (ISO-8601 formatted date)</td>
        </tr>
    </tbody>
</table>

### Response

Status | Response |
------ | ---------|
202 | ``` { "policyId": "1", "customerNumber": "IT15K", "product": "Public Liability", "startDate": "2018-12-14T14:00:00+00:0"} ```
401 | ```{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }```
401 | ```{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }```
400 | ```{ "error":"INVALID_DATA", "message": "Invalid data format", "detail": { "policyOptions": { "startDate": "\`startDate\` cannot be in the past."} } }```
