# README

## About me

https://gist.github.com/neudabei/ff79cd01aff9aa14af82ce3c86c2ddf4

## The reedsy-backend-challenge

This application uses Rails 7.0.4 and Ruby 3.0.4
It runs on a PostgreSQL database.

I tried to split up this work into atomic commits, to make each change easier to follow.

### Installation

This repo has also been deployed to
https://reedsy-challenge-backend.onrender.com/


To run this app, cd into the `reedsy-challenge-backend` directoy and:

```sh
$ bundle install
$ bundle exec rails db:create
$ bundle exec rails db:migrate
$ bundle exec rails server
```

##### Test suite

Specs can be run with `$rspec .`

### API description

###### Overview

The API has 3 endpoints. It follows the [JSON::API v1.1 spec](https://jsonapi.org/).

```sh
GET /products
```

```sh
PATCH /products/:id

JSON body:

{
  "data": {
    "type": "products",
    "id": "1",
    "attributes": {
      "price": "800"
    }
  }
}


```

```sh
POST /baskets

JSON body:

{
  "data": {
    "type": "basket",
    "discount": "true", # optional to enable discounts
    "attributes": {},
    "relationships": {
      "products": {
        "data": [
          {
            "code": "mug",
            "quantity": "200"
          },
          {
            "code": "tshirt",
            "quantity": "4"
          },
          {
            "code": "hoodie",
            "quantity": "1"
          }
        ]
      }
    }
  }
}

```

Note that all cURL commands can be run against localhost:3000 when running locally, or on the deployed version:

https://reedsy-challenge-backend.onrender.com/


##### Question 1

```sh
curl 'localhost:3000/products' --header 'Content-Type: application/json'
```

```sh
# response

{
  "data": [
    {
      "id": "1",
      "type": "products",
      "attributes": {
        "code": "tshirt",
        "name": "Reedsy T-shirt",
        "price": "15.00",
        "updated-at": "2022-11-15T07:18:14.496Z"
      }
    },
    {
      "id": "3",
      "type": "products",
      "attributes": {
        "code": "hoodie",
        "name": "Reedsy Hoodie",
        "price": "20.00",
        "updated-at": "2022-11-15T07:18:14.497Z"
      }
    },
    {
      "id": "1",
      "type": "products",
      "attributes": {
        "code": "mug",
        "name": "Reedsy Mug",
        "price": "8.00",
        "updated-at": "2022-11-15T07:56:06.288Z"
      }
    }
  ]
}

```

##### Question 2

```sh
curl --location --request PATCH 'localhost:3000/products/1' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data": {
        "type": "products",
        "id": "1",
        "attributes": {
            "price": "800"
        }
    }
}'
```

```sh
# response

{
  "data": {
    "id": "1",
    "type": "products",
    "attributes": {
      "code": "mug",
      "name": "Reedsy Mug",
      "price": "8.00",
      "updated-at": "2022-11-15T07:56:06.288Z"
    }
  }
}

```

##### Question 3

```sh

# Please make sure to reset prices to the right amounts if they have been changed previously.

curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "1"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "1"
                        },
                        {
                            "code": "hoodie",
                            "quantity": "1"
                        }

                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "140",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "1" }, { "tshirt": "1" }, { "hoodie": "1" }],
      "total": "41.00",
      "updated-at": "2022-11-15T08:19:01.543Z"
    }
  }
}
```

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "2"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "1"
                        }

                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "141",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "2" }, { "tshirt": "1" }],
      "total": "27.00",
      "updated-at": "2022-11-15T08:19:57.203Z"
    }
  }
}

```

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "3"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "1"
                        }

                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "143",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "3" }, { "tshirt": "1" }],
      "total": "33.00",
      "updated-at": "2022-11-15T08:21:11.183Z"
    }
  }
}
```

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "2"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "4"
                        },
                        {
                            "code": "hoodie",
                            "quantity": "1"
                        }
                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "144",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "2" }, { "tshirt": "4" }, { "hoodie": "1" }],
      "total": "92.00",
      "updated-at": "2022-11-15T08:22:03.795Z"
    }
  }
}
```

##### Question 4

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "discount": "true",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "1"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "1"
                        },
                                                {
                            "code": "hoodie",
                            "quantity": "1"
                        }
                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "151",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "1" }, { "tshirt": "1" }, { "hoodie": "1" }],
      "total": "41.00",
      "updated-at": "2022-11-15T08:29:52.126Z"
    }
  }
}
```

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "discount": "true",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "9"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "1"
                        }
                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "153",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "9" }, { "tshirt": "1" }],
      "total": "69.00",
      "updated-at": "2022-11-15T08:31:26.807Z"
    }
  }
}
```

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "discount": "true",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "10"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "1"
                        }
                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "155",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "10" }, { "tshirt": "1" }],
      "total": "73.80",
      "updated-at": "2022-11-15T08:32:23.558Z"
    }
  }
}
```

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "discount": "true",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "45"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "3"
                        }
                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": {
    "id": "157",
    "type": "baskets",
    "attributes": {
      "product-summary": [{ "mug": "45" }, { "tshirt": "3" }],
      "total": "279.90",
      "updated-at": "2022-11-15T08:33:22.373Z"
    }
  }
}
```

```sh
curl --location --request POST 'localhost:3000/baskets' \
--header 'Content-Type: application/json' \
--data-raw '{
    "data":
        {
            "type": "basket",
            "discount": "true",
            "attributes": {
            },
            "relationships": {
                "products": {
                    "data": [
                        {
                            "code": "mug",
                            "quantity": "200"
                        },
                        {
                            "code": "tshirt",
                            "quantity": "4"
                        },
                        {
                            "code": "hoodie",
                            "quantity": "1"
                        }
                    ]
                }
            }
        }
}'
```

```sh
# response

{
  "data": { "id": "158",
    "type": "baskets",
    "attributes": {
      "product-summary": [
        { "mug": "200" },
        { "tshirt": "4" },
        { "hoodie": "1" }
      ],
      "total": "902.00",
      "updated-at": "2022-11-15T08:34:46.709Z"
    }
  }
}
```

