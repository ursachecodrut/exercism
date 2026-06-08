// &'static is a "lifetime specifier", something you'll learn more about later
pub fn hello() -> &'static str {
    println!("Debug message");
    let secret_number = 4321;
    println!("My banking password is {}, which is better than {}.", secret_number, 1200 + 34);
    let words = vec!["hello", "world"];
    println!("words that are often combined: {:?}", words);
    "Hello, World!"
}
