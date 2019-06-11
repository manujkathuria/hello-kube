create table campaign_blacklist
(
    blacklist_value text,
    campaign_code text,
    primary key (blacklist_value, campaign_code)
);

create table campaign_location
(
    campaign_code text,
    customer_id text,
    trigger_tracker map<text, frozen<location_tracker>>,
    primary key (customer_id, campaign_code)
);

create table campaign_whitelist
(
    campaign_code text,
    whitelist_value text,
    primary key (whitelist_value, campaign_code)
);

create table sms_blacklist
(
    blacklist_value text primary key
);

create table sms_blacklist_swap
(
    blacklist_value text primary key
);

