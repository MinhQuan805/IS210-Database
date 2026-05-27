# Promotion Code on Client Booking (Design)

## Overview
Add an optional promotion code input on the client booking form and apply it at booking time. The backend validates and applies the discount during booking creation. Invalid codes return a clear error message and the booking is not created.

## Goals
- Allow guests to enter an optional promotion code when booking.
- Validate and apply the promotion during booking creation.
- Show a clear error message when the code is invalid or expired.

## Non-Goals
- Pre-validation endpoint for promotions.
- Applying promotions after booking creation.
- Multiple promotions per booking.

## User Flow
1. Guest fills booking form and optionally enters a promotion code.
2. Guest submits booking.
3. Backend validates promotion and applies discount if valid.
4. If invalid, backend returns a clear error message and booking is not created.

## API Changes
- Extend create booking request to include an optional `promotionCode`.
- If `promotionCode` is empty or missing, treat as `null`.

## Backend Changes
- Pass `promotionCode` into booking creation flow.
- Ensure stored procedure receives `p_promotion_code`.
- Return `400` with a clear message when promotion is invalid.

## Database Logic
- Use existing promotion validation in `fn_calculate_promotion_discount`.
- Increment promotion `used_count` when successfully applied.
- Associate the booking with the promotion in `booking_promotions`.

## Error Handling
- On invalid/expired/maxed-out code, surface a clear error message to the client.
- Client displays the server `message` in a visible toast or form error area.

## Frontend Changes
- Add a small optional input for promotion code on the client booking form.
- Submit `promotionCode` only if not empty.
- Display backend error message when booking fails due to invalid code.

## Testing Notes
- Create booking with no promotion code succeeds.
- Create booking with valid promotion code applies discount.
- Create booking with invalid/expired promotion code fails with a clear message.
- Create booking with promotion exceeding `max_uses` fails with a clear message.
