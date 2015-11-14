using ECommon.Components;
using ENode.EQueue;
using ENode.Eventing;

namespace NoteSample.ConsoleApp
{
    [Component]
    public class DomainEventTopicProvider : AbstractTopicProvider<IDomainEvent>
    {
        public override string GetTopic(IDomainEvent evnt)
        {
            return "NoteEventTopic";
        }
    }
}
