SELECT
   r.name AS region,
   p.name AS producer,   
   w.name AS wine,
   c.vintage,
   c.bottles,
   x.name AS size,
   c.price
--   c.cprice,
--   c.updated,
--   c.bracket,
--   c.drink,
--   c.notes,
--   c.scores,
--   t.name as type,
--   l.name as location,
--   s.name as status,
--   v.name as vendor
FROM
   collection c,
   winenames w,
   producers p,
   types t,
   locations l,
   status s,
   region r,
   vendor v,
   sizes  x

WHERE
   c.winenameid = w.winenameid AND
   c.prodid     = p.prodid AND
   c.typeid     = t.typeid AND
   c.locid      = l.locid AND
   c.statusid   = s.statusid AND
   c.regionid   = r.regionid AND
   c.vendorid   = v.vendorid AND
   c.sizeid     = x.sizeid
ORDER BY
   r.name, w.name, p.name, c.vintage
   
