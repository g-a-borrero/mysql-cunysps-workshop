SELECT
videos.id AS 'Video ID',
videos.title AS 'Title',
videos.URL AS 'URL',
videos.length AS 'Video Length',
reviewers.rating AS 'Rating',
reviewers.name AS 'Reviewer',
reviewers.review AS 'Review'
FROM videos
INNER JOIN reviewers
ON videos.id = reviewers.vidID
ORDER BY videos.id ASC, reviewers.rating ASC;