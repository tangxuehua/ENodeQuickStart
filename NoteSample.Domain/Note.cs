using ENode.Domain;
using ENode.Infrastructure;

namespace NoteSample.Domain
{
    [Code(100)]
    public class Note : AggregateRoot<string>
    {
        private string _title;

        public Note(string id, string title) : base(id)
        {
            ApplyEvent(new NoteCreatedEvent(this, title));
        }

        public void ChangeTitle(string title)
        {
            ApplyEvent(new NoteTitleChangedEvent(this, title));
        }

        private void Handle(NoteCreatedEvent evnt)
        {
            _id = evnt.AggregateRootId;
            _title = evnt.Title;
        }
        private void Handle(NoteTitleChangedEvent evnt)
        {
            _title = evnt.Title;
        }
    }
}
