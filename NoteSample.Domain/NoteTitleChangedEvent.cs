using ENode.Eventing;
using ENode.Infrastructure;

namespace NoteSample.Domain
{
    [Code(101)]
    public class NoteTitleChangedEvent : DomainEvent<string>
    {
        public string Title { get; private set; }

        public NoteTitleChangedEvent() { }
        public NoteTitleChangedEvent(Note note, string title) : base(note)
        {
            Title = title;
        }
    }
}
