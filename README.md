# Perfect Labeler – Backend Module

## About This Project
Perfect Labeler is a SaaS application where users can create and manage receipt or label designs.
In this project, I worked on the backend part using Supabase.
The backend stores receipt designs and receipt elements and ensures that each user can access only their own data, even though multiple users use the same system.
## Tools Used
- Supabase (PostgreSQL database, authentication, REST APIs)
- PostgreSQL
- Postman
- curl (for API examples)
## Database Tables

### receipt_designs
This table stores the basic details of a receipt or label design.

Columns:
- id
- tenant_id
- name
- width
- height
- created_at
### receipt_elements
This table stores the elements inside a receipt design such as text, QR code, logo, etc.

Columns:
- id
- design_id
- tenant_id
- element_type
- position_x
- position_y
- width
- height
- content
- properties
- created_at

## Authentication
Users sign up and log in using email and password through Supabase authentication.
After successful login, Supabase provides an access token (JWT).

This token is sent with every API request using the Authorization header.
## API Usage (Postman / curl)

### Login (Get Access Token)
POST https://fironxetytkixomlyugt.supabase.co/auth/v1/token?grant_type=password

Body:
{
  "email": "raihanabanu231@gmail.com",
  "password": "<R@y@1234>"
}

---

### Create Design
POST /rest/v1/receipt_designs

Body:
{
  "tenant_id": "<user_id>",
  "name": "Week 3 First Label",
  "width": 400,
  "height": 200
}
### Get Designs
GET /rest/v1/receipt_designs

This request returns only the designs created by the logged-in user.
### Update Design
PATCH /rest/v1/receipt_designs?id=eq.<design_id>

Body:
{
  "name": "Updated Label Name"
}


### Delete Design
DELETE /rest/v1/receipt_designs?id=eq.<design_id>

All APIs were tested using Postman and curl.

## Security Model
Row Level Security (RLS) is enabled on all tables.
Each record contains a tenant_id which represents the owner of the data.

RLS ensures that:
- Users can read only their own data
- Users cannot insert, update, or delete other users’ data

This provides multi-tenant data isolation in the application.

## Validation Enhancement (Week 4 Task)
Each receipt element uses position_x and position_y values to decide where it should be placed.

Negative values for position_x or position_y are not valid because elements would be placed outside the receipt or label area.

To avoid this, validation is required to ensure:
- position_x >= 0
- position_y >= 0

This validation helps maintain correct layout and data consistency.

## What I Learned
- How Supabase authentication works using JWT
- How Row Level Security helps in multi-tenant applications
- How backend APIs are designed and tested
- How to test APIs using Postman and curl
- Importance of validation in backend systems
