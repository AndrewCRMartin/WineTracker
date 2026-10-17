SELECT
   c.statusid AS "STATUS",
   c.sizeid AS "SIZE",
   r.name AS "REGION",
   c.bracket AS "BRACKET",
   t.name AS "TYPE",
   p.name AS "PRODUCER",   
   w.name AS "WINENAME",
   c.vintage AS "VINTAGE",
   c.drink AS "DRINK",
   c.bottles AS "NUMBER",
   c.price AS "PRICE",
   v.name AS "VENDOR",
   c.scores AS "SCORE",
   c.notes AS "NOTES",
   c.cprice AS "CPRICE",
   c.updated AS "UPDATED",
   l.name AS "LOCATION"
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
   
