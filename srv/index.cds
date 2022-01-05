using { cap.sample.app.db as db} from '../db/index';

service BookService{
    entity Books as projection on db.Book;
}