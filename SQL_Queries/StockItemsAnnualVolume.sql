SELECT
  d.Year,
  f.StockItemID,
  s.StockItemName,
  SUM(f.Quantity)        AS TotalUnits,
  AVG(f.UnitPrice)       AS AvgUnitPrice
FROM
  `lab3-bi-20252.lab3_bi_conjunto.FactTableOrderLines` AS f
JOIN
  `lab3-bi-20252.lab3_bi_conjunto.DimDates`      AS d
  ON f.DateID = d.DateID
JOIN
  `lab3-bi-20252.lab3_bi_conjunto.DimStockItem`  AS s
  ON f.StockItemID = s.StockItemID
-- si quieres limitar a un rango de años:
-- WHERE d.Year BETWEEN 2013 AND 2014
GROUP BY
  d.Year,
  f.StockItemID,
  s.StockItemName
QUALIFY
  ROW_NUMBER() OVER (
    PARTITION BY d.Year
    ORDER BY SUM(f.Quantity) DESC
  ) <= 10
ORDER BY
  d.Year,
  TotalUnits DESC;

