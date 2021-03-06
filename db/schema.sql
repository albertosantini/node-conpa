DROP TABLE IF EXISTS portfolios;

CREATE TABLE portfolios (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now() NOT NULL,
    assets TEXT[] NOT NULL,
    weights NUMERIC[] NOT NULL,
    ref DATE DEFAULT CURRENT_DATE - INTERVAL '1 year' NOT NULL,
    ret NUMERIC NOT NULL,
    risk NUMERIC NOT NULL,
    perf NUMERIC NOT NULL,
    lows NUMERIC[] NOT NULL,
    highs NUMERIC[] NOT NULL
);

DROP FUNCTION IF EXISTS getmostusedassets;

CREATE OR REPLACE FUNCTION getmostusedassets()
    RETURNS TABLE (
        frequency bigint,
        name text
    )
    LANGUAGE sql
AS $$
    select count(*) as frequency, unnest(assets) as name
    from portfolios
    group by(name)
    order by frequency desc;
$$
