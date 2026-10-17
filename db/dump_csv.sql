SELECT
   c.statusid as STATUS,
   c.sizeid as SIZE,
   r.name AS REGION,
   c.bracket as BRACKET,
   t.name as TYPE,
   p.name AS PRODUCER,   
   w.name AS WINENAME,
   c.vintage as VINTAGE,
   c.drink as DRINK,
   c.bottles as NUMBER,
   c.price as PRICE,
   v.name as VENDOR,
   c.scores as SCORE,
   c.notes as NOTES,
   c.cprice as CPRICE,
   c.updated as UPDATED,
   l.name as LOCATION
FROM
   collection c,
   winenames w,
   producers p,
   types t,
   locations l,
   region r,
   vendor v
WHERE
   c.winenameid = w.winenameid AND
   c.prodid     = p.prodid AND
   c.regionid   = r.regionid AND
   c.typeid     = t.typeid AND 
   c.locid      = l.locid AND
   c.vendorid   = v.vendorid 
ORDER BY
   r.name, t.name, c.bracket, w.name, p.name, c.vintage
   
