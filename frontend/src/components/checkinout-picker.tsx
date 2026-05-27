import { useState, useEffect } from 'react'
import { Label } from '@/components/ui/label'
import { DatePicker } from '@renderer/components/ui/date-picker'

type CheckInOutValue = {
  checkIn: Date | undefined
  checkOut: Date | undefined
}

type Props = {
  defaultValue?: CheckInOutValue
  onChange?: (value: CheckInOutValue) => void
}

export default function CheckInOutPicker({ defaultValue, onChange }: Props) {
  const [value, setValue] = useState<CheckInOutValue>({
    checkIn: defaultValue?.checkIn,
    checkOut: defaultValue?.checkOut
  })

  const [errors, setErrors] = useState<{
    checkIn?: string
    checkOut?: string
  }>({})

  useEffect(() => {
    const newErrors: typeof errors = {}

    if (!value.checkIn) {
      newErrors.checkIn = 'Hãy chọn ngày check-in'
    }

    if (!value.checkOut) {
      newErrors.checkOut = 'Hãy chọn ngày check-out'
    }

    if (value.checkIn && value.checkOut && value.checkIn >= value.checkOut) {
      newErrors.checkOut = 'Ngày check-out phải sau check-in'
    }

    setErrors(newErrors)

    // emit ra ngoài
    onChange?.(value)
  }, [value])

  const updateValue = (newValue: Partial<CheckInOutValue>) => {
    setValue((prev) => {
      const next = { ...prev, ...newValue }

      // auto fix UX
      if (next.checkIn && next.checkOut && next.checkIn > next.checkOut) {
        next.checkOut = next.checkIn
      }

      return next
    })
  }

  return (
    <div className="flex flex-col gap-1">
      <Label>Ngày nhận / trả phòng</Label>

      {/* INPUT GROUP */}
      <div className="flex">
        {/* CHECK IN */}
        <div className="flex-1">
          <DatePicker
            selected={value.checkIn}
            onSelect={(date) => updateValue({ checkIn: date })}
            className="rounded-r-none border-r-0"
          />
        </div>

        {/* CHECK OUT */}
        <div className="flex-1">
          <DatePicker
            selected={value.checkOut}
            onSelect={(date) => updateValue({ checkOut: date })}
            className="rounded-l-none"
          />
        </div>
      </div>

      {/* ERROR (chung) */}
      {(errors.checkIn || errors.checkOut) && (
        <p className="text-red-500 text-sm">{errors.checkIn || errors.checkOut}</p>
      )}
    </div>
  )
}
