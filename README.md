# Query Registered Businesses in the Vicinity

The frontend sends a location and the backend returns a list of registered businesses in the vicinity  
with their respective id, name and location, and the information, whether the business has already been verified.

## Endpoint

    /api/businesses?lng=xxxxxx&lat=xxxxxx
    
## Type

    http GET

## Parameters

Longitude `lng` and latitude `lat` are set to floating point numbers with . as decimal separator.

## Return Value

List of businesses in JSON format each with the following properties
* google maps id (text)
* name
* longitude
* latitude
* business type
* business type icon uri
* verification status
* phone number (as text)
* street address
* postcode (as text)
* city

Example:

    [
        // business 1
        {
            gmap_id : "42",
            name : "Feuermelder",
            longitude : 13.4590208,
            latitude : 52.5097213,
            type : "Bar",
            icon_uri : "?",
            verified : true,
            phone_number : "0302911937",
            street_address : "Krossener Str. 24",
            postcode : "10245",
            city : "Berlin",
        }
        // business 2
        {
            ...
        }
    ]

## Failure Return Value

Empty List `[]`
    

# Query Owner Details of Selected Business

The details of the selected business and owner for the detailed view and a possible donation are returned.

## Endpoint

    /api/businesses/:id

## Type

    http GET

## Parameters

The `:id` is the google maps id of the selected business.

## Return Value

Owner details
* google maps id
* nick name
* personal message
* personal thank you
* paypal handle (for now paypal.me link after http://paypal.me/)
* image(s)?

Example:

    {
        gmap_id : "42",
        nick_name : "Durstlรถscher",        
        message : "Spende ein halbes Bier!",
        thank_you : "Danke!",
        paypal : "feuermelder",
        images : [???]
    }

## Failure Return Value

Empty object? Exception object?
    

# Register New Business

All necessary information to register and verify a new company is sent to the backend at once.

## Endpoint

    /api/businesses

## Type

    http POST

## Parameters

Business and owner details plus documents for verification. `business_type_id` still has to receive a mapping

Example:
```
    {
    	"gmap_id": "huisdfhuias7sadyf7s8dyd",
    	"name": "Feuermelder",
    	"lng": 13.4590208,
    	"lat": 52.5097213,
    	"phone_number": "0302911937",
    	"street_address": "Krossener Str. 24",
    	"postcode": "10245",
    	"city": "Berlin",
    	"personal_message": "Spende ein halbes Bier!",
    	"personal_thank_you": "Danke!",
    	"business_type_id": 1,
    	"owner": {
    		"email": "hello@world.de",
    		"first_name": "Mein",
    		"last_name": "Name",
    		"salutation": "Mr.",
    		"nick_name": "Worldwide",
    		"paypal_handle": "robinzuschke"
    	}
    }
```

## Response

Http code 201

## Failure Response

Http code 422
    

# Log donation for Business

Before the user is redirected to paypal.me, we make this call to our backend  
to keep track of the - promised - donations.

## Endpoint

    /api/businesses/:id/donation
    
Where the `:id` is the google maps id of the business, for which a donation will be made.

## Type

    http POST

## Parameters

An object containing the promised amount in Euro Cents.
(we could also send the google maps id as part of the payload instead of the url)

Example:

    {
        amount : 1000 // 10 euros
    }

## Response

Http code ?

## Failure Response

Http code ?
(should probably be ignored in the frontend)


