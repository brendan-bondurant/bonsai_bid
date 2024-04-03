<div align="center">
<h1> Bonsai Bid </h1>

## :computer: Tech Stack <br>
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=for-the-badge&logo=github&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
![Notion](https://img.shields.io/badge/Notion-%23000000.svg?style=for-the-badge&logo=notion&logoColor=white)
![Github Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white)
![Heroku](https://img.shields.io/badge/Heroku-430098?style=for-the-badge&logo=heroku&logoColor=white)
![Ruby on Rails](https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![YAML](https://img.shields.io/badge/yaml-%23ffffff.svg?style=for-the-badge&logo=yaml&logoColor=151515)
![Docker](https://img.shields.io/badge/Docker-2CA5E0?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
</div>

## :closed_book: Abstract

Bonsai Bid is a simple, yet powerful online auction platform dedicated to serving the national community of bonsai enthusiasts. Inspired by the bustling, yet inefficient bonsai trading within private Facebook groups, Bonsai Bid is designed to streamline and elevate the buying and selling experience. Our mission is to create a user-friendly, bonsai-specific marketplace that produces unparalleled experiences for both the buyer and seller.


<br></br>
## Status
This app is still in development, but I am happy to share the deployment with anyone who would like to look at it - Brendan
<br></br>

### Features and Functionalities
#### Bidding System
Users can place bids on items, get notified when outbid, win auctions, and set up auto-bids.
#### User Dashboard
Users can view their watched items.
#### Item Management
Sellers can create, update, and delete item listings, with specific controls based on user authentication and authorization.
#### Feedback System
Users can leave feedback on transactions, with features to edit and reply to feedback.
#### Item Inquiry
Buyers can communicate with sellers for inquiries related to items.
#### Authentication and Authorization
Secure user login system with session management.
#### Search Functionality
Robust search feature enabling users to find items based on keywords.
#### Watchlist
Users can add items to their watchlist and manage them.
### Database Schema
This project uses PostgreSQL for its database, this is a simplified schema

### `bids`

| Column       | Data Type | Constraints                        |
|--------------|-----------|------------------------------------|
| `id`         | bigint    | Primary Key                        |
| `item_id`    | bigint    | Not Null, Foreign Key (`items.id`) |
| `bidder_id`  | bigint    | Not Null, Foreign Key (`users.id`) |
| `bid_amount` | float     |                                    |
| `bid_time`   | datetime  |                                    |
| `created_at` | datetime  | Not Null                           |
| `updated_at` | datetime  | Not Null                           |

### `categories`

| Column       | Data Type | Constraints                        |
|--------------|-----------|------------------------------------|
| `id`         | bigint    | Primary Key                        |
| `name`       | string    |                                    |
| `description`| text      |                                    |
| `parent_id`  | bigint    | Foreign Key (`categories.id`)      |
| `created_at` | datetime  | Not Null                           |
| `updated_at` | datetime  | Not Null                           |

### `feedbacks`

| Column              | Data Type | Constraints                              |
|---------------------|-----------|------------------------------------------|
| `id`                | bigint    | Primary Key                              |
| `item_id`           | bigint    | Not Null, Foreign Key (`items.id`)       |
| `from_user_id`      | bigint    | Not Null, Foreign Key (`users.id`)       |
| `to_user_id`        | bigint    | Not Null, Foreign Key (`users.id`)       |
| `rating`            | integer   |                                          |
| `comment`           | text      |                                          |
| `created_at`        | datetime  | Not Null                                 |
| `updated_at`        | datetime  | Not Null                                 |
| `sale_transaction_id` | bigint  | Not Null, Foreign Key (`sale_transactions.id`) |
| `reply`             | text      |                                          |

### `items` 

| Column             | Data Type | Constraints                             |
|--------------------|-----------|-----------------------------------------|
| `id`               | bigint    | Primary Key                             |
| `seller_id`        | bigint    | Not Null, Foreign Key (`users.id`)      |
| `category_id`      | bigint    | Not Null, Foreign Key (`categories.id`) |
| `name`             | string    |                                         |
| `description`      | text      |                                         |
| `images`           | text      |                                         |
| `starting_price`   | float     |                                         |
| `current_price`    | float     |                                         |
| `buy_it_now_price` | float     |                                         |
| `start_date`       | datetime  |                                         |
| `end_date`         | datetime  |                                         |
| `status`           | integer   | Not Null, Default: 0                    |
| `created_at`       | datetime  | Not Null                                |
| `updated_at`       | datetime  | Not Null                                |
| `bid_increment`    | float     |                                         |

### `replies`

| Column       | Data Type | Constraints                           |
|--------------|-----------|---------------------------------------|
| `id`         | bigint    | Primary Key                           |
| `content`    | text      |                                       |
| `feedback_id`| bigint    | Not Null, Foreign Key (`feedbacks.id`)|
| `created_at` | datetime  | Not Null                              |
| `updated_at` | datetime  | Not Null                              |

### `sale_transactions`

| Column          | Data Type | Constraints                              |
|-----------------|-----------|------------------------------------------|
| `id`            | bigint    | Primary Key                              |
| `buyer_id`      | bigint    | Foreign Key (`users.id`)                 |
| `seller_id`     | bigint    | Foreign Key (`users.id`)                 |
| `item_id`       | bigint    | Not Null, Foreign Key (`items.id`)       |
| `final_price`   | decimal   |                                          |
| `created_at`    | datetime  | Not Null                                 |
| `updated_at`    | datetime  | Not Null                                 |
| `payment_status`| integer   | Not Null, Default: 0                     |

### `users` 
| Column                 | Data Type | Constraints               |
|------------------------|-----------|---------------------------|
| `id`                   | bigint    | Primary Key               |
| `email`                | string    | Not Null, Unique          |
| `password_digest`      | string    | Not Null                  |
| `name`                 | string    |                           |
| `address`              | text      |                           |
| `phone`                | string    |                           |
| `created_at`           | datetime  | Not Null                  |
| `updated_at`           | datetime  | Not Null                  |
| `encrypted_password`   | string    | Not Null, Default: ""     |
| `reset_password_token` | string    |                           |
| `reset_password_sent_at`| datetime |                          |
| `remember_created_at`  | datetime  |                           |

### `watchlists` 
| Column       | Data Type | Constraints                         |
|--------------|-----------|-------------------------------------|
| `id`         | bigint    | Primary Key                         |
| `user_id`    | bigint    | Not Null, Foreign Key (`users.id`)  |
| `item_id`    | bigint    | Not Null, Foreign Key (`items.id`)  |
| `created_at` | datetime  | Not Null                            |
| `updated_at` | datetime  | Not Null                            |


#### Authors
[Brendan Bondurant](https://www.linkedin.com/in/brendanbondurant) | [Github](https://github.com/brendan-bondurant)
<br></br>



</div>









