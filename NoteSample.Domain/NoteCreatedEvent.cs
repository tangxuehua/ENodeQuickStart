using ENode.Eventing;
using ENode.Infrastructure;

namespace NoteSample.Domain
{
    [Code(100)]
    public class NoteCreatedEvent : DomainEvent<string>
    {
        public string Title { get; private set; }

        public NoteCreatedEvent() { }
        public NoteCreatedEvent(Note note, string title) : base(note)
        {
            Title = title;
        }
    }
}
