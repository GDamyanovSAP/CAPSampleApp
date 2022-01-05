using { cap.sample.app.db as db} from '../db/index';

service BookService{
    entity BooksCollection as projection on db.Book;
}