---
title: Zego API Specification

language_tabs: # must be one of https://git.io/vQNgJ
  - python

toc_footers:
  - <a href='https://www.zego.com'>www.zego.com</a>

includes:
  - shifts
  - customers
  - workflows
  - webhooks
  - versions
  

search: true
---

# Introduction

The Zego API presets a simple **RESTful** interface for interacting with Zego for Partners and on behalf of Zego Customers.
By providing a Zego Customer ID, or Partner Customer ID, Users of the API can request the Zego insured status of a Customer, notify Zego of a Customer starting work, and perform other actions.

## Authentication

```python
[...]
import requests

response = requests.get(
    f'https://api.zego.com/v1/user/status/?workProviderUserId=1234',
    headers={'Authorization': AUTHORIZATION_CODE},  # header value set as token
)
```

Authenticating with the API requires a token to be set as the **AUTHORIZATION** header value. The token
can requested from your Zego Partnerships Manager. 


## Making requests
Some of the API methods require identification of a particular Zego customer.
This can be done in one of two ways:

- ``customerNumber`` is a unique identifier that Zego assigns to each of its customers.
- ``workProviderUserId`` is an identifier assigned by the work provider to uniquely identify its drivers.

Zego can obtain this identifier during customer signup, and use it to identify that customer during communication with the applicable work provider.
    
<aside class="notice">
Previous version of this API used the <code>policyId</code> and <code>driverId</code> fields instead of <code>customerNumber</code> and <code>workProviderUserId</code> respectively.
Although these fields are still supported by the api, they have been deprecated and should no longer be used in new integrations.
</aside>

## Errors
When the API encounters an error with your request, it will respond with a HTTP status code in the 5xx
or 4xx range and a JSON body with an error code and detail (if applicable or available) of the error
that occurred.

> Example error response body

```json
{
  "error":"INVALID_DATA", 
  "detail": "JSON decode error at line 1, column 2" 
}
```

