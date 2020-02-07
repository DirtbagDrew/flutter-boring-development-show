class Article {
  final String text;
  final String domain;
  final String by;
  final String age;
  final int score;
  final int commentsCount;

  const Article(
      {this.text,
      this.domain,
      this.by,
      this.age,
      this.score,
      this.commentsCount});
}

final articles = [
  new Article(
      text: "How the Lakers-Clippers rivalry spilled into the trade deadline",
      domain: "www.espn.com",
      by: "Brian Whitwurst",
      age: "1 hour",
      score: 10,
      commentsCount: 25),
  new Article(
      text:
          "Everything you need to know about the league trying to challenge the PGA Tour",
      domain: "www.espn.com",
      by: "Bob Harig",
      age: "4 hours",
      score: 25,
      commentsCount: 30),
  new Article(
      text:
          "Qualifying for the U.S. Olympic golf team: How to do it and Tiger's chances",
      domain: "www.espn.com",
      by: "Bob Harig",
      age: "10 Days",
      score: 25,
      commentsCount: 230),
  new Article(
      text:
          "From Tiger Woods to Brooks Koepka and Rory McIlroy, what will happen in golf in 2020 according to The Caddie",
      domain: "www.espn.com",
      by: "Michael Collins",
      age: "6 hours",
      score: 17,
      commentsCount: 36),
  new Article(
      text: "Nick Taylor leads Pebble Beach Pro-Am after first round",
      domain: "www.espn.com",
      by: "Associated Press",
      age: "10 hours",
      score: 1,
      commentsCount: 22),
  new Article(
      text:
          "Brooks Koepka won't agree to midround TV interviews: 'I don't get it'",
      domain: "www.espn.com",
      by: "Bob Harig",
      age: "3 days",
      score: 66,
      commentsCount: 600),
  new Article(
      text: "Webb Simpson rallies to beat Tony Finau in Phoenix Open playoff",
      domain: "www.espn.com",
      by: "Associated Press ",
      age: "3 days",
      score: 7,
      commentsCount: 79),
  new Article(
      text: "Graeme McDowell faces possible penalty after slow-play violation",
      domain: "www.espn.com",
      by: "Bob Harig",
      age: "6 years",
      score: 77,
      commentsCount: 80),
  new Article(
      text:
          "LPGA event canceled, Olympic qualifiers rescheduled amid coronavirus concerns",
      domain: "www.espn.com",
      by: "ESPN News Services",
      age: "1 week",
      score: 11,
      commentsCount: 22),
];
