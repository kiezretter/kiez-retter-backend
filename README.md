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
* business id
* google maps id
* name
* longitude
* latitude
* verification status

Example:
```
    [
      {
        "id": 1,
        "gmap_id": "huisdfhuias7sadyf7s8dyd",
        "name": "Feuermelder",
        "lng": 13.4590208,
        "lat": 52.5097213,
        "verified": true,
      },
      {
        "id": 2,
        "gmap_id": null,
        "name": "Burgeramt",
        "lat": 52.5099916,
        "lng": 13.460808,
        "verified": null
      }
    ]
```

## Failure Return Value

Empty List `[]`
    

# Query Owner Details of Selected Business

The details of the selected business and owner for the detailed view and a possible donation are returned.

## Endpoint

    /api/businesses/:id

## Type

    http GET

## Parameters

The `:id` is the internal id of the selected business, which was returned in the list of businesses in the vicinity.

## Return Value

Owner details
* business id
* google maps id
* nick name
* personal message
* personal thank you
* paypal handle (for now paypal.me link after http://paypal.me/)
* one image of the business
* optionally one image of the owner

Example:
```
    {
      "business_id": 1, 
      "gmap_id": "huisdfhuias7sadyf7s8dyd",
      "nick_name": "Feuermelder",        
      "message": "Spende ein halbes Bier!",
      "thank_you": "Danke!",
      "paypal": "feuermelder",
      "business_type: "bar",
      "favorite_place_image": "https://kiezretter.imgix.net/h93e6a8zg0tmjmpusqxo2x0hntic?ixlib=rails-4.0.0",
      "owner_image": "https://kiezretter.imgix.net/h93e6a8zg0tmjmpusqxo2x0hntic?ixlib=rails-4.0.0"
    }
```

The image URLs can be modified in order to return different dimensions (and much more). See the [Imgix API reference](https://docs.imgix.com/apis/url) for details.

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
Images are transferred using base64 encoding.

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
      "business_type": "bar",
      "favorite_place_image": { 
        "data": "data:image/png;base64,iVBORw" 
      },
      "owner_attributes": {
        "email": "hello@world.de",
        "first_name": "Mein",
        "last_name": "Name",
        "salutation": "Mr.",
        "nick_name": "Worldwide",
        "paypal_handle": "robinzuschke",
        "owner_image": { 
          "data": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABPYA" 
        },
        "id_card_image": {
          "data": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABPYA"
        }
      },
      "trade_certificate_attributes": {
        "trade_licence_image": {
          "data: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABPYA"
        }
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

    /api/donations

## Type

    http POST

## Parameters
Where the `business_id` is the id of the business, for which a donation will be made.
An object containing the promised amount in Euro Cents.

Example:
```
    {
      "business_id": 1,
      "amount_cents": 500
    }
```

## Response

Http code 201

## Failure Response

Http code 422
(should probably be ignored in the frontend)


