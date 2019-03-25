# Public Liability Occupations

## /v2/public-liability-occupations/

This endpoint returns the list of public liability occupations supported by our products.

When creating fixed term policies via the /v2/policy/ endpoint, you can use the value in the `code` field to create a policy with that occupation.

### Request
 
 
 Method | URL |
------ | ---|
GET   | /v2/public-liability-occupations/ | 

</table>

### Response

Status | Response |
------ | ---------|
200 | `` { "occupations": [{ "code": "actuary", "label": "Actuary" }, { "code": "advertising_agency", "label": "Advertising Agency" }]} ``
401 | ``{ "error":"MISSING_AUTH", "detail": "Authorization header missing" }``
401 | ``{ "error":"INVALID_KEY", "detail": "Authorization key is invalid" }``
)`

