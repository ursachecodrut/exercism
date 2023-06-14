defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  defprotocol Edible do
    def eat(edible, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(loaf_of_bread, character) do
      {nil, %Character{character | health: character.health + 5}}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(mana_potion, character) do
      {%EmptyBottle{}, %Character{character | mana: character.mana + mana_potion.strength}}
    end
  end

  defimpl Edible, for: Poison do
    def eat(poison, character) do
      {%EmptyBottle{}, %Character{character | health: 0}}
    end
  end
end
