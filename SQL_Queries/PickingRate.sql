SELECT
  si.StockItemID,
  si.StockItemName,
  SUM(f.Quantity)       AS OrderedQuantity,
  SUM(f.PickedQuantity) AS PickedQuantity,
  SAFE_DIVIDE(
    SUM(f.PickedQuantity),
    NULLIF(SUM(f.Quantity), 0)
  ) AS PickingRate
FROM
  `lab3-bi-20252.lab3_bi_conjunto.FactTableOrderLines` AS f
JOIN
  `lab3-bi-20252.lab3_bi_conjunto.DimStockItem` AS si
ON
  f.StockItemID = si.StockItemID
JOIN
  `lab3-bi-20252.lab3_bi_conjunto.DimDates` AS d
ON
  f.DateID = d.DateID
WHERE
  d.Year = 2014
GROUP BY
  si.StockItemID,
  si.StockItemName
HAVING
  SUM(f.Quantity) > 100
ORDER BY
  PickingRate ASC;

