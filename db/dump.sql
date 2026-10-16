SELECT    
   w.name,
   c.vintage,
   c.bottles,
   c.price
--   c.cprice,
--   c.updated,
--   c.bracket,
--   c.drink,
--   c.notes,
--   c.scores,
--   t.name,
--   l.name,
--   s.name,
--   v.name
FROM
   collection c,
   winenames w,
   types t,
   locations l,
   status s,
   region r,
   vendor v

WHERE
   c.winenameid = w.winenameid AND
   c.typeid     = t.typeid AND
   c.locid      = l.locid AND
   c.statusid   = s.statusid AND
   c.regionid   = r.regionid AND
   c.vendorid   = v.vendorid
   
   
